module VagrantPlugins
  module Invade
    module InvadeModule
      module AnsibleLocal

        class AnsibleLocal <  InvadeModule

          attr_reader :result
          attr_accessor :machine_name, :ansible_local_data

          def initialize(machine_name, ansible_local_data, result: nil)
            @machine_name = machine_name
            @ansible_local_data = ansible_local_data
            @result = result
          end

          def build
            b = binding

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for ansible_local provisioner section
              playbook = @ansible_local_data['playbook']
              verbose = @ansible_local_data['verbose']
              install = @ansible_local_data['install']
              install_mode = @ansible_local_data['install_mode']
              limit = @ansible_local_data['limit']
              inventory_path = @ansible_local_data['inventory_path']
              provisioning_path = @ansible_local_data['provisioning_path']
              tmp_path = @ansible_local_data['tmp_path']
              version = @ansible_local_data['version']

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
