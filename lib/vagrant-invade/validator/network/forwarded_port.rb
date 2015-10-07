module VagrantPlugins
  module Invade
    module Validator

      module Network

        #(see https://docs.vagrantup.com/v2/networking/forwarded_ports.html)
        class ForwardedPort

          attr_accessor :env
          attr_accessor :forwarded_port

          DEFAULT = {
            'guest' => 80,
            'guest_ip' => nil, # Use Vagrant default: every network
            'host' => 8080,
            'host_ip' => nil, # Use Vagrant default: bount to every ip
            'protocol' => nil, # Use Vagrant default: TCP
            'auto_correct' => nil # Use Vagrant default: TRUE
          }

          def initialize(env, forwarded_port)
            @env = env
            @forwarded_port = forwarded_port
          end

          def validate
            return nil unless @forwarded_port

            # GUEST
            @forwarded_port['guest'] = Validator.validate_string(
              @forwarded_port['guest'], 'guest', DEFAULT['guest']
            )

            # GUEST IP
            @forwarded_port['guest_ip'] = Validator.validate_string(
              @forwarded_port['guest_ip'], 'guest_ip', DEFAULT['guest_ip']
            )

            # HOST
            @forwarded_port['host'] = Validator.validate_string(
              @forwarded_port['host'], 'host', DEFAULT['host']
            )

            # HOST IP
            @forwarded_port['host_ip'] = Validator.validate_string(
              @forwarded_port['host_ip'], 'host_ip', DEFAULT['host_ip']
            )

            # PROTOCOL
            @forwarded_port['protocol'] = Validator.validate_string(
              @forwarded_port['protocol'], 'protocol', DEFAULT['protocol']
            )

            # AUTO CORRECT
            @forwarded_port['auto_correct'] = Validator.validate_string(
              @forwarded_port['auto_correct'], 'auto_correct', DEFAULT['auto_correct']
            )

            @forwarded_port
          end

        end

      end
    end
  end
end
