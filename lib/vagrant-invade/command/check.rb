require 'optparse'
require_relative 'base'

module VagrantPlugins
  module Invade
    module Command
      class Check < Base
        def execute
          options = {}
          opts = OptionParser.new do |o|
            o.banner = 'Usage: vagrant invade check [-h]'
          end

          # Parse the options
          argv = parse_options(opts)
          return unless argv

          # Validates InVaDE configuration
          action(Action.check, {
            :invade_generate => true,
            :invade_validate_quiet => true,
            :invade_build_quiet => true
          })

          # Success, exit status 0
          0
        end
      end
    end
  end
end
