module VagrantPlugins
  module Invade
    module Validator

      class SSH

        attr_accessor :env, :ssh

        DEFAULT = {
          'enabled' => nil,
          'path' => '~/.ssh/'
        }

        def initialize(env, ssh)
          @env = env
          @ssh = ssh
        end

        def validate
          return DEFAULT unless @ssh

          # ENABLED
          @ssh['enabled'] = Validator.validate_boolean(
            @ssh['enabled'], 'enabled', DEFAULT['enabled']
          )

          # PATH TO HOST SSH FOLDER
          @ssh['path'] = Validator.validate_string(
            @ssh['path'], 'path', DEFAULT['path']
          )

          @ssh
        end

      end
    end
  end
end
