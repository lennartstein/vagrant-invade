module VagrantPlugins
  module Invade
    module Validator

      class Invade

        attr_accessor :env
        attr_accessor :invade

        DEFAULT = {
          'enabled' => true,
          'debug' => false
        }

        def initialize(env, invade)
          @env = env
          @invade = invade
        end

        def validate
          return DEFAULT unless @invade

          @invade['enabled']  = Validator.validate(@invade['enabled'], 'enabled', 'bool', DEFAULT['enabled'])
          @invade['debug']    = Validator.validate(@invade['debug'], 'debug', 'bool', DEFAULT['debug'])

          @invade
        end

      end
    end
  end
end
