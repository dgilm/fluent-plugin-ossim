fluent-plugin-ossim
===================

Alienvault's Ossim plugin for fluent Event Collector

# Overview

This input plugin allows you to receive events from ossim agent.

# Installation

~~~~~
    gem install fluent-plugin-ossim
~~~~~

# Configuration

~~~~~
    <source>
      type ossim
      bind 0.0.0.0
      port 40001
    </source>
~~~~~

