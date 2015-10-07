module VagrantPlugins
  module Invade
    module Validator

      module Network

        #(see https://docs.vagrantup.com/v2/networking/public_network.html)
        class PublicNetwork

          attr_accessor :env
          attr_accessor :public_network

          DEFAULT = {
            'type' => nil, # Use default. Vagrant default is NIL if not set
            'ip' => nil, # Use default. Vagrant default is NIL if not set
            'bridge' => nil, # Use default. Vagrant default is NIL if not set
            'auto_config' => nil # Use default. Vagrant default is TRUE if not set
          }

          def initialize(env, public_network)
            @env = env
            @public_network = public_network
          end

          def validate
            return nil unless @public_network

            # NETWORK TYPE
            @public_network['type'] = Validator.validate_string(
              @public_network['type'], 'type', DEFAULT['type']
            )

            # IP ADDRESS
            @public_network['ip'] = Validator.validate_string(
              @public_network['ip'], 'ip', DEFAULT['ip']
            )

            # BRIDGE SETTINGS
            @public_network['bridge'] = Validator.validate_array(
              @public_network['bridge'], 'bridge', DEFAULT['bridge']
            )

            # AUTO CONFIG
            @public_network['auto_config'] = Validator.validate_boolean(
              @public_network['auto_config'], 'auto_config', DEFAULT['auto_config']
            )

            @public_network
          end
        end

      end

    end
  end
end
