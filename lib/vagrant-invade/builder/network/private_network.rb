module VagrantPlugins
  module Invade
    module Builder
      module Network
        require 'erubis'

        class PrivateNetwork

          attr_reader :result
          attr_accessor :machine_name, :private_network_data

          def initialize(machine_name, private_network_data, result: nil)
            @machine_name = machine_name
            @private_network_data = private_network_data
            @result = result
          end

          def build
            b = binding
            template_file = "#{TEMPLATE_PATH}/network/private_network.erb"

            begin
              # Get machine name
              machine_name = @machine_name

              # Values for network section
              ip = @private_network_data['ip']
              ip ? dhcp = nil : dhcp = @private_network_data['dhcp']
              auto_config = @private_network_data['auto_config']

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
end
