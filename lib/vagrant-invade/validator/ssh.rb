module VagrantPlugins
  module Invade
    module Validator

      class SSH

        attr_accessor :env, :ssh

        DEFAULT = {
          'forward_agent' => true,
          'enabled' => true,
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

          @ssh['forward_agent'] = Validator.validate_boolean(
            @ssh['forward_agent'], 'forward_agent', DEFAULT['forward_agent']
          )

          @ssh
        end

      end
    end
  end
end
