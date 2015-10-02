module VagrantPlugins
  module Invade
    module Validator
      module Plugin

        class HostManager

          attr_accessor :env
          attr_accessor :hostmanager

          DEFAULT = {
            'enabled' => true,
            'manage_host' => true,
            'ignore_private_ip' => false,
            'include_offline' => true,
            'aliases' => nil
          }

          def initialize(env, hostmanager)
            @env = env
            @hostmanager = hostmanager
          end

          def validate
            return nil unless @hostmanager

            @hostmanager['enabled'] =  Validator.validate_boolean(
              @hostmanager['enabled'], 'enabled', DEFAULT['enabled']
            )

            # MANAGE HOST (updates hosts /etc/hosts file)
            @hostmanager['manage_host'] = Validator.validate_boolean(
              @hostmanager['manage_host'], 'manage_host', DEFAULT['manage_host']
            )

            # IGNORE PRIVATE IP (machine's IP address is defined by either the static IP for a private network configuration or by the SSH host configuration)
            @hostmanager['ignore_private_ip'] = Validator.validate_boolean(
              @hostmanager['ignore_private_ip'], 'ignore_private_ip', DEFAULT['ignore_private_ip']
            )

            # INCLUDE OFFLINE (boxes that are up or have a private ip configured will be added to the hosts file)
            @hostmanager['include_offline'] = Validator.validate_boolean(
              @hostmanager['include_offline'], 'include_offline', DEFAULT['include_offline']
            )

            # ALIASES
            @hostmanager['aliases'] = Validator.validate_array(
              @hostmanager['aliases'], 'aliases', DEFAULT['aliases']
            )

            @hostmanager
          end
        end
      end
    end
  end
end
