module VagrantPlugins
  module Invade
    module InvadeModule
      module Invade

        class Machine < InvadeModule

          attr_reader :result
          attr_accessor :machine_data

          def initialize(machine_name, machine_data, result: nil)
            @machine_name = machine_name
            @machine_data  = machine_data
            @result   = result
          end

          def build
            b = binding

            begin

              # Machine name
              machine_name = @machine_name

              # Data to build machine entry
              vm = @machine_data['vm']
              network = @machine_data['network']
              ssh = @machine_data['ssh']
              provider = @machine_data['provider']
              synced_folder = @machine_data['synced_folder']
              plugin = @machine_data['plugin']
              provision = @machine_data['provision']

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
