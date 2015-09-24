module VagrantPlugins
  module Invade
    module Generator

      require 'erb'

      class Network

        attr_reader :result
        attr_accessor :machine_name, :options

        def initialize(machine_name, options, result: nil)
          @machine_name = machine_name
          @options  = options
          @result   = result
        end

        def build
          b = binding
          template_file = "#{TEMPLATE_PATH}/network/network.erb"

          begin

            # Get machine name
            machine_name = @machine_name

            # Values for network section
            type  = options['type']
            ip = options['ip']
            hostname = options['hostname']

            ERB.new(File.read(template_file), 0, '-', '@result').result b
          rescue TypeError, SyntaxError, SystemCallError => e
            raise(e)
          end
        end
      end
    end
  end
end
