module VagrantPlugins
  module Invade
    module InvadeModule
      module Provider

        class Vmware < InvadeModule

          attr_reader :result
          attr_accessor :machine_name, :vmware_data

          def initialize(machine_name, vmware_data, result: nil)
            @machine_name = machine_name
            @vmware_data  = vmware_data
            @result   = result
          end

          def build
            b = binding

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for provider section
              @vmware_data['name'] ? name = @vmware_data['name'] : name = @machine_name
              gui = @vmware_data['gui']
              cpus = @vmware_data['cores']
              memory  = @vmware_data['memory']

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
