require 'optparse'
require_relative 'base'

module VagrantPlugins
  module Invade
    module Command
      class Init < Base
        def execute
          options = {}
          opts = OptionParser.new do |o|
            o.banner = 'Usage: vagrant invade init [-f|--force] [-h]'
            o.separator ''
            o.on('-f', '--force', 'Force creating configuration file.') do |f|
              options[:force] = f
            end
          end

          # Parse the options
          argv = parse_options(opts)
          return if !argv

          # Init InVaDE configuration file
          action(Action.init, {
            :invade_command_init_force => options[:force]
          })

          # Success, exit status 0
          0
        end
      end
    end
  end
end
