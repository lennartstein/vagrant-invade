module VagrantPlugins
  module Invade
    module Generator

      class Machine

        attr_accessor :machine_data

        def initialize(machine_name, machine_data)
            @machine_name = machine_name
            @machine_data = machine_data
        end

        def generate
            machine = Builder::Machine.new(@machine_name, @machine_data)
            machine.build

            machine.result
        end

      end

    end
  end
end
