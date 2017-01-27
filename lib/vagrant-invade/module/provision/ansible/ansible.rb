module VagrantPlugins
  module Invade
    module InvadeModule
      module Ansible

        class Ansible <  InvadeModule

          attr_reader :result
          attr_accessor :machine_name, :ansible_data

          def initialize(machine_name, ansible_data, result: nil)
            @machine_name = machine_name
            @ansible_data = ansible_data
            @result = result
          end

          def build
            b = binding

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for ansible provisioner section
              playbook = @ansible_data['playbook']
              groups = @ansible_data['groups']
              limit = @ansible_data['limit']
              inventory_path = @ansible_data['inventory_path']
              ask_sudo_pass = @ansible_data['ask_sudo_pass']
              ask_vault_pass = @ansible_data['ask_vault_pass']
              force_remote_user = @ansible_data['force_remote_user']
              host_key_checking = @ansible_data['host_key_checking']
              host_vars = @ansible_data['host_vars']
              raw_ssh_args = @ansible_data['raw_ssh_args']
              raw_arguments = @ansible_data['raw_arguments']

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
