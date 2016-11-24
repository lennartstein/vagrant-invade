module VagrantPlugins
  module Invade
    module InvadeModule
      module Provision

        class PuppetApply < InvadeModule

          attr_reader :result
          attr_accessor :machine_name, :puppet_apply_data

          def initialize(machine_name, puppet_apply_data, result: nil)
            @machine_name = machine_name
            @puppet_apply_data = puppet_apply_data
            @result = result
          end

          def build
            b = binding

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for provider puppet_apply section
              binary_path = @puppet_apply_data['binary_path']
              environment = @puppet_apply_data['environment']
              environment_path = @puppet_apply_data['environment_path']
              options = @puppet_apply_data['options']
              module_path = @puppet_apply_data['module_path']
              manifests_path = @puppet_apply_data['manifests_path']
              manifest_file = @puppet_apply_data['manifest_file']
              hiera_config_path = @puppet_apply_data['hiera_config_path']
              synced_folder_type = @puppet_apply_data['synced_folder_type']
              synced_folder_args = @puppet_apply_data['synced_folder_args']
              temp_dir = @puppet_apply_data['temp_dir']
              working_directory = @puppet_apply_data['working_directory']
              facter = @puppet_apply_data['facter']

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
