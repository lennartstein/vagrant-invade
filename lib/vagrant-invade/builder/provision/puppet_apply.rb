module VagrantPlugins
  module Invade
    module Builder
      module Provision

        require 'erubis'

        class PuppetApply

          attr_reader :result
          attr_accessor :machine_name, :puppet_apply_data

          def initialize(machine_name, puppet_apply_data, result: nil)
            @machine_name = machine_name
            @puppet_apply_data = puppet_apply_data
            @result = result
          end

          def build
            b = binding
            template_file = "#{TEMPLATE_PATH}/provision/puppet_apply.erb"

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for provider puppet_apply section
              module_path = @puppet_apply_data['module_path']
              manifests_path = @puppet_apply_data['manifests_path']
              manifest_file = @puppet_apply_data['manifest_file']
              hiera_config_path = @puppet_apply_data['hiera_config_path']
              facter = @puppet_apply_data['facter']

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
