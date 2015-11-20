module VagrantPlugins
  module Invade
    module Validator

      class SSH

        attr_accessor :env, :ssh

        DEFAULT = {
          'forward_agent' => true
        }

        def initialize(env, ssh)
          @env = env
          @ssh = ssh
        end

        def validate
          return DEFAULT unless @ssh

          @ssh['forward_agent'] = Validator.validate_boolean(
            @ssh['forward_agent'], 'forward_agent', DEFAULT['forward_agent']
          )

          @ssh
        end

      end
    end
  end
end
