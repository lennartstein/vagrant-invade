module VagrantPlugins
  module Invade
    module Builder

      require 'erubis'

      class Network

        attr_reader :result
        attr_accessor :machine_name, :network_data

        def initialize(machine_name, network_data, result: nil)
          @machine_name = machine_name
          @network_data  = network_data
          @result   = result
        end

        def build
          b = binding
          template_file = "#{TEMPLATE_PATH}/network/network.erb"

          begin

            # Get machine name
            machine_name = @machine_name

            # Values for network section
            type  = @network_data['type']
            ip = @network_data['ip']
            hostname = @network_data['hostname']

            eruby = Erubis::Eruby.new(File.read(template_file))
            @result = eruby.result b
          rescue TypeError, SyntaxError, SystemCallError => e
            raise(e)
          end
        end
      end
    end
  end
end
