require 'socket'

class OssimInput < Fluent::Input

  Fluent::Plugin.register_input('ossim', self)

  CONNECT_MSG       = "connect id"
  CONNECT_RESPONSE  = "ok id=\"1\"\n"

  def configure(conf)
    super
    @bind = '0.0.0.0'
    @port = conf['port'] || 40001
  end

  def start
    super
    @server = TCPServer.new @bind, @port
    $log.debug "listening ossim on #{@bind}:#{@port}"
    @thread = Thread.new(&method(:run))
  end

  def shutdown
  end

  def run
    loop do
      Thread.start(@server.accept) do |client|

        while line = client.gets

          # returns ok to connect string
          if line.start_with? CONNECT_MSG
            client.puts CONNECT_RESPONSE

          # discard plugin status information
          elsif line.start_with? 'plugin-'
            nil

          # emit event
          elsif line.start_with? 'event ' or
                line.start_with? 'snort-event ' or
                line.start_with? 'host-os-event ' or
                line.start_with? 'host-mac-event '
            emit(line)
          end
        end

        client.close
      end
    end
  end

  protected
  # Converts to json the line received by the ossim server
  def line2json(line)
    json = {}

    # fill json with the next key="value" pairs
    line.scan(/(\w+)=\"([^"]+)\"/).each do |attr|
      json[attr[0]] = attr[1]
    end

    json
  end

  private
  def emit(line)
    plugin  = "test"
    tag     = "ossim.#{plugin}"   # TODO: use plugin name into tag
    time    = Time.now.to_i       # TODO: use event date instead of now
    record  = line2json(line)

    Fluent::Engine.emit(tag, time, record)
  end

end

