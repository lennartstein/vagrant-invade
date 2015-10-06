module VagrantPlugins
  module Invade
    module Generator
      module Section

        class Network

          attr_accessor :machine_name, :network_data

          def initialize(machine_name, network_data)
            @machine_name = machine_name
            @network_data = network_data
          end

          def generate
            network = Builder::Network.new(@machine_name, @network_data)
            network.build

            network.result
          end

        end
      end
    end
  end
end
