module VagrantPlugins
  module Invade
    module Validator
      module Provider

        class VirtualBox

          attr_accessor :env
          attr_accessor :virtualbox

          DEFAULT = {
            'gui' => nil,
            'natdns' => nil,
            'nicspeed' => 10485760
          }

          def initialize(env, virtualbox)
            @env = env
            @virtualbox = Provider.validate_base(env, virtualbox)
          end

          def validate
            return nil unless @virtualbox

            # GUI
            @virtualbox['gui'] = Validator.validate_boolean(
              @virtualbox['gui'], 'gui', DEFAULT['gui']
            )

            # HOSTRESOLVER
            @virtualbox['natdns'] = Validator.validate_boolean(
              @virtualbox['natdns'], 'natdns', DEFAULT['natdns']
            )

            # NICSPEED
            @virtualbox['nicspeed'] = Validator.validate_integer(
              @virtualbox['nicspeed'], 'nicspeed', DEFAULT['nicspeed']
            )

            @virtualbox
          end
        end
      end
    end
  end
end
