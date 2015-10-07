module VagrantPlugins
  module Invade
    module Builder
      module Network
        require 'erubis'

        class PublicNetwork

          attr_reader :result
          attr_accessor :machine_name, :public_network_data

          def initialize(machine_name, public_network_data, result: nil)
            @machine_name = machine_name
            @public_network_data = public_network_data
            @result = result
          end

          def build
            b = binding
            template_file = "#{TEMPLATE_PATH}/network/public_network.erb"

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for network section
              ip = @public_network_data['ip']
              dhcp = @public_network_data['dhcp']
              bridge = @public_network_data['bridge']
              auto_config = @public_network_data['auto_config']

              eruby = Erubis::Eruby.new(File.read(template_file))
              @result = eruby.result b
            rescue StandardError => e
              raise(e)
            end
          end
        end
      end
    end
  end
end
