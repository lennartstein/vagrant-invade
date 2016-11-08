module VagrantPlugins
  module Invade
    module Module
      module Provision

        class PuppetApply < Module

          attr_reader :result
          attr_accessor :machine_name, :puppet_apply_data

          def initialize(machine_name, puppet_apply_data, result: nil)
            @machine_name = machine_name
            @salt_data = puppet_apply_data
            @result = result
          end

          def build
            b = binding
            template_file = "#{TEMPLATE_PATH}/provision/puppet_apply.erb"

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for provider puppet_apply section
              module_path = @salt_data['module_path']
              manifests_path = @salt_data['manifests_path']
              manifest_file = @salt_data['manifest_file']
              hiera_config_path = @salt_data['hiera_config_path']
              facter = @salt_data['facter']

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
