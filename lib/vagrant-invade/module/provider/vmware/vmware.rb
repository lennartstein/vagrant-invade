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
            template_file = "#{TEMPLATE_PATH}/provider/vmware.erb"

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for provider section
              @vmware_data['name'] ? name = @vmware_data['name'] : name = @machine_name
              cpus = @vmware_data['cores']
              memory  = @vmware_data['memory']

              eruby = Erubis::Eruby.new(File.read(template_file))
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
