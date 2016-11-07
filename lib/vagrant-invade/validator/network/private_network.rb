module VagrantPlugins
  module Invade
    module Validator

      require 'pp'

      module Network

        #(see https://docs.vagrantup.com/v2/networking/private_network.html)
        class PrivateNetwork

          attr_accessor :private_network

          DEFAULT = {
            :type => 'dhcp',
            :ip => nil,
            :netmask => nil,
            :auto_config => false
          }

          def initialize(private_network)
            @private_network = private_network
          end

          def validate
            return nil unless @private_network

            # NETWORK TYPE
            @private_network['type'] = Validator.validate_string(
              @private_network['type'], 'type', DEFAULT[:type]
            )

            # IP ADDRESS
            @private_network['ip'] = Validator.validate_string(
              @private_network['ip'], 'ip', DEFAULT[:ip]
            )

            # NETMASK (IPv6 only)
            @private_network['netmask'] = Validator.validate_string(
              @private_network['netmask'], 'netmask', DEFAULT[:netmask]
            )

            # AUTO CONFIG
            @private_network['auto_config'] = Validator.validate_boolean(
              @private_network['auto_config'], 'auto_config', DEFAULT[:auto_config]
            )

            @private_network
          end
        end

      end

    end
  end
end
