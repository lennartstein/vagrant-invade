module VagrantPlugins
  module Invade
    module Validator
      module Provider

        class VMware

          attr_accessor :env
          attr_accessor :vmware

          DEFAULT = {}

          def initialize(env, vmware)
            @env = env
            @vmware = Provider.validate_base(env, vmware)
          end

          def validate
            return nil unless @vmware

            @vmware
          end
        end
      end
    end
  end
end
