module VagrantPlugins
  module Invade
    module Generator
      module MachinePart

        class VM

          attr_accessor :machine_name, :vm_data

          def initialize(machine_name, vm_data)
            @machine_name = machine_name
            @vm_data = vm_data
          end

          def generate
            vm = Builder::VM.new(@machine_name, @vm_data)
            vm.build

            vm.result
          end

        end

      end
    end
  end
end
