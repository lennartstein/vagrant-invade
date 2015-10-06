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

          # INVADE ON/OFF
          @invade['enabled']  = Validator.validate_boolean(
            @invade['enabled'], 'enabled', DEFAULT['enabled']
          )

          # DEBUG MODE ON/OFF
          @invade['debug']    = Validator.validate_boolean(
            @invade['debug'], 'debug', DEFAULT['debug']
          )

          @invade
        end

      end
    end
  end
end
