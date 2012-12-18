# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name = "fluent-plugin-ossim"
  gem.description = "This input plugin allows you to receive events from Ossim"
  gem.summary = gem.description
  gem.version = "0.0.1"
  gem.authors = ["David Gil"]
  gem.email = "david.gil.marcos@gmail.com"
  gem.has_rdoc = false
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']
  gem.add_dependency "fluentd", "~> 0.10.25"
end


