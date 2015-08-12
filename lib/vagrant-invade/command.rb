module VagrantPlugins
  module Invade
    class Command < Vagrant.plugin('2', :command)
      # Show description when `vagrant list-commands` is triggered
      def self.synopsis
        'manages vagrant due a configuration file'
      end

      def execute
        require 'optparse'

        options = {}
        opts = OptionParser.new do |o|
          o.banner = 'Usage: vagrant invade'
          o.separator ''
          o.version = VagrantPlugins::Invade::VERSION
          o.program_name = 'vagrant invade'
        end

        # Parse the options and return if we don't have any target.
        argv = parse_options(opts)
        return unless argv

        # Success, exit status 0
        0
      end
    end
  end

end
