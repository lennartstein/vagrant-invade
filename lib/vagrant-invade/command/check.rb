require 'optparse'
require_relative 'base'

module VagrantPlugins
  module Invade
    module Command
      class Check < Base
        def execute
          options = {}
          opts = OptionParser.new do |o|
            o.banner = 'Usage: vagrant invade check [-f|--force] [-q|--quiet] [-h|--help]'
            o.separator ''
            o.on('-q', '--quiet', 'No verbose output.') do |q|
              options[:quiet] = q
            end
          end

          # Parse the options
          argv = parse_options(opts)
          return unless argv

          # Validates InVaDE configuration
          action(Action.check, {
            :invade_validate_quiet => true # set this to true. Just build without validate output
          })

          # Success, exit status 0
          0
        end
      end
    end
  end
end
