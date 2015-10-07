module VagrantPlugins
  module Invade
    module Validator

      module Network

        #(see https://docs.vagrantup.com/v2/networking/private_network.html)
        class PrivateNetwork

          attr_accessor :env
          attr_accessor :private_network

          DEFAULT = {
            'type' => 'dhcp',
            'ip' => nil # Use default. Vagrant default is NIL if not set
          }

          def initialize(env, private_network)
            @env = env
            @private_network = private_network
          end

          def validate
            return nil unless @private_network

            # NETWORK TYPE (DHCP, not used if IP is given)
            @private_network['type'] = Validator.validate_string(
              @private_network['type'], 'type', DEFAULT['type']
            )

            # IP ADDRESS
            @private_network['ip'] = Validator.validate_string(
              @private_network['ip'], 'ip', DEFAULT['ip']
            )

            @private_network
          end
        end

      end

    end
  end
end
