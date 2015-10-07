module VagrantPlugins
  module Invade
    module Generator
      module Section

        class Network

          attr_accessor :machine_name, :type, :network_data

          def initialize(machine_name, type, network_data)
            @machine_name = machine_name
            @type = type
            @network_data = network_data
          end

          def generate

            case @type
            when 'private', 'private_network', 'privatenetwork', 'private-network'
              network = Builder::Network::PrivateNetwork.new(@machine_name, @network_data)
            when 'forwarded', 'forwarded_port', 'forwarded-port', 'forwardedport', 'port'
              network = Builder::Network::ForwardedPort.new(@machine_name, @network_data)
            when 'public', 'puplic_network', 'publicnetwork', 'public-network'
              network = Builder::Network::PublicNetwork.new(@machine_name, @network_data)
            else
              raise StandardError, "Network type unknown or not set. Please check the network configuration."
            end

            network.build

            network.result
          end

        end
      end
    end
  end
end
