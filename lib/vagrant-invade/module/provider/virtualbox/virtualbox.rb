module VagrantPlugins
  module Invade
    module InvadeModule
      module Provider

        class Virtualbox < InvadeModule

          attr_reader :result
          attr_accessor :machine_name, :virtualbox_data

          def initialize(machine_name, virtualbox_data, result: nil)
            @machine_name = machine_name
            @virtualbox_data  = virtualbox_data
            @result   = result
          end

          def build
            b = binding

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for provider section
              @virtualbox_data['name'] ? name = @virtualbox_data['name'] : name = @machine_name
              gui = @virtualbox_data['gui']
              type = @virtualbox_data['type']
              cpus = @virtualbox_data['cores']
              cpu_cap = @virtualbox_data['cpu_gap']
              memory = @virtualbox_data['memory']
              nicspeed = @virtualbox_data['nicspeed']
              natdns = @virtualbox_data['natdns']
              linked_clone = @virtualbox_data['linked_clone']

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
