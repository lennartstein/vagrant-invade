module VagrantPlugins
  module Invade
    module Generator
      module MachinePart

        class SSH

          attr_accessor :machine_name, :ssh_data

          def initialize(machine_name, ssh_data)
            @machine_name = machine_name
            @ssh_data = ssh_data
          end

          def generate
            vm = Builder::SSH.new(@machine_name, @ssh_data)
            vm.build

            vm.result
          end

        end

      end
    end
  end
end
