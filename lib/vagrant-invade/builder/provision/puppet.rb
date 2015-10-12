module VagrantPlugins
  module Invade
    module Builder
      module Provision

        require 'erubis'

        class Puppet

          attr_reader :result
          attr_accessor :machine_name, :puppet_data

          def initialize(machine_name, puppet_data, result: nil)
            @machine_name = machine_name
            @puppet_data = puppet_data
            @result = result
          end

          def build
            b = binding
            template_file = "#{TEMPLATE_PATH}/provision/puppet.erb"

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for provider puppet section
              module_path = @puppet_data['module_path']
              manifests_path = @puppet_data['manifests_path']
              manifest_file = @puppet_data['manifest_file']
              hiera_config_path = @puppet_data['hiera_config_path']
              facter = @puppet_data['facter']

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
