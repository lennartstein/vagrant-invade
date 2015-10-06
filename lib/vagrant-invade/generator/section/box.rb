module VagrantPlugins
  module Invade
    module Generator
      module Section

        class Box

          attr_accessor :machine_name, :box_data

          def initialize(machine_name, box_data)
            @machine_name = machine_name
            @box_data = box_data
          end

          def generate
            box = Builder::Box.new(@machine_name, @box_data)
            box.build

            box.result
          end

        end

      end
    end
  end
end
