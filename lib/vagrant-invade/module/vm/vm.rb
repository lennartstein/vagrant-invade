module VagrantPlugins
  module Invade
    module InvadeModule
      class Vm < InvadeModule

        attr_reader :result
        attr_accessor :machine_name, :vm_data

        def initialize(machine_name, vm_data, result: nil)
          @machine_name = machine_name
          @vm_data  = vm_data
          @result   = result
        end

        def build
          b = binding

          begin

            # Get machine name
            machine_name = @machine_name

            # Values for vm section
            box  = @vm_data['box']
            url   = @vm_data['url']
            hostname = @vm_data['hostname']

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
