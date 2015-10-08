module VagrantPlugins
  module Invade
    module Validator

      class Invade

        attr_accessor :env
        attr_accessor :invade

        DEFAULT = {
          'auto' => false,
          'debug' => false
        }

        def initialize(env, invade)
          @env = env
          @invade = invade
        end

        def validate
          return nil unless @invade

          # INVADE ON/OFF
          @invade['auto'] = Validator.validate_boolean(
            @invade['auto'], 'auto', DEFAULT['auto']
          )

          # DEBUG MODE ON/OFF
          @invade['debug'] = Validator.validate_boolean(
            @invade['debug'], 'debug', DEFAULT['debug']
          )

          @invade
        end

      end
    end
  end
end
