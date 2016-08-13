module VagrantPlugins
  module Invade
    module Validator

      class HostManager

        attr_accessor :env
        attr_accessor :hostmanager

        DEFAULT = {
          'enabled' => false,
          'manage_host' => true,
          'manage_guest' => true,
          'ignore_private_ip' => false,
          'include_offline' => true
        }

        def initialize(hostmanager)
          @hostmanager = hostmanager
        end

        def validate
          return nil unless @hostmanager

          # ENABLED
          @hostmanager['enabled'] = Validator.validate_boolean(
            @hostmanager['enabled'], 'enabled', DEFAULT['enabled']
          )

          # MANAGE HOST
          @hostmanager['manage_host'] = Validator.validate_boolean(
            @hostmanager['manage_host'], 'manage_host', DEFAULT['manage_host']
          )

          # MANAGE GUEST
          @hostmanager['manage_guest'] = Validator.validate_boolean(
            @hostmanager['manage_guest'], 'manage_guest', DEFAULT['manage_guest']
          )

          # IGNORE PRIVATE IP
          @hostmanager['ignore_private_ip'] = Validator.validate_boolean(
            @hostmanager['ignore_private_ip'], 'ignore_private_ip', DEFAULT['ignore_private_ip']
          )

          # INCLUDE OFFLINE
          @hostmanager['include_offline'] = Validator.validate_boolean(
            @hostmanager['include_offline'], 'include_offline', DEFAULT['include_offline']
          )

          @hostmanager
        end

      end
    end
  end
end
