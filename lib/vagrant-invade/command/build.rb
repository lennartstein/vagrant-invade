require 'optparse'
require_relative 'base'

module VagrantPlugins
  module Invade
    module Command
      class Build < Base
        def execute
          options = {}
          opts = OptionParser.new do |o|
            o.banner = 'Usage: vagrant invade build [-q|--quiet] [-h|--help]'
            o.separator ''
            o.on('-q', '--quiet', 'No verbose output.') do |q|
              options[:quiet] = q
            end
          end

          # Parse the options
          argv = parse_options(opts)
          return unless argv

          # Validates InVaDE configuration
          action(Action.build, {
            :invade_build_quiet => options[:quiet],
            :invade_validate_quiet => true,
            :invade_generate => true
          })

          # Success, exit status 0
          0
        end
      end
    end
  end
end
