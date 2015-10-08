require 'optparse'
require_relative 'base'

module VagrantPlugins
  module Invade
    module Command
      class Validate < Base
        def execute
          options = {}
          opts = OptionParser.new do |o|
            o.banner = "Usage: vagrant invade validate [-f|--force] [-q|--quiet] [-h]"
            o.separator ""
            o.on("-f", "--force", "Overwrite existing Vagrantfile") do |f|
              options[:force] = f
            end
            o.on("-q", "--quiet", "Just make it whisper.") do |q|
              options[:quiet] = q
            end
          end

          # Parse the options
          argv = parse_options(opts)
          return if !argv

          # Validates InVaDE configuration
          action(Action.validate, {
            :invade_validate_force => options[:force],
            :invade_validate_quiet => options[:quiet]
          })

          # Success, exit status 0
          0
        end
      end
    end
  end
end
