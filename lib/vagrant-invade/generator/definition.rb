module VagrantPlugins
  module Invade
    module Generator

      class Definition

        attr_accessor :definition_data

        def initialize(machine_name, definition_data)
            @machine_name = machine_name
            @definition_data = definition_data
        end

        def generate
            definition = Builder::Definition.new(@machine_name, @definition_data)
            definition.build

            definition.result
        end

      end

    end
  end
end
