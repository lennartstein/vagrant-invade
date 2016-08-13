module VagrantPlugins
  module Invade
    module Validator
      module Plugin

        class HostManager

          attr_accessor :env
          attr_accessor :hostmanager

          DEFAULT = {
            'aliases' => nil
          }

          def initialize(env, hostmanager)
            @env = env
            @hostmanager = hostmanager
          end

          def validate
            return nil unless @hostmanager

            # ALIASES
            @hostmanager['aliases'] = Validator.validate_array(
              @hostmanager['aliases'], 'aliases', DEFAULT['aliases']
            )

            @hostmanager
          end
        end
      end
    end
  end
end
