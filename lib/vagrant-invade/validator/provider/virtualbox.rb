module VagrantPlugins
  module Invade
    module Validator
      module Provider

        class VirtualBox

          attr_accessor :env
          attr_accessor :virtualbox

          DEFAULT = {
            'gui' => false,
            'natdns' => false,
            'nicspeed' => 10485760
          }

          def initialize(env, virtualbox)
            @env = env
            @virtualbox = Provider.validate_base(env, virtualbox)
          end

          def validate
            return nil unless @virtualbox

            # GUI
            @virtualbox['gui'] = Validator.validate(
              @virtualbox['gui'], 'gui', 'boolean', DEFAULT['gui']
            )

            # HOSTRESOLVER
            @virtualbox['natdns'] = Validator.validate(
              @virtualbox['natdns'], 'natdns', 'boolean', "#{DEFAULT['natdns']}"
            )

            # NICSPEED
            @virtualbox['nicspeed'] = Validator.validate(
              @virtualbox['nicspeed'], 'nicspeed', 'integer', "#{DEFAULT['nicspeed']}"
            )

            @virtualbox
          end
        end
      end
    end
  end
end
