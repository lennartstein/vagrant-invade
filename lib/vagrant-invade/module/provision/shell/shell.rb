module VagrantPlugins
  module Invade
    module InvadeModule
      module Provision

        class Shell <  InvadeModule

          attr_reader :result
          attr_accessor :machine_name, :shell_data

          def initialize(machine_name, shell_data, result: nil)
            @machine_name = machine_name
            @shell_data  = shell_data
            @result   = result
          end

          def build
            b = binding

            begin

              # Get machine name
              machine_name = @machine_name
              data = @shell_data

              eruby = Erubis::Eruby.new(File.read(self.get_template_path(__FILE__)))
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
