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
            @vmware = vmware
          end

          def validate
            return false unless vmware

          end
        end
      end
    end
  end
end
