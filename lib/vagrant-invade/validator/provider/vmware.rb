module VagrantPlugins
  module Invade
    module Validator
      module Provider

        class VMware

          attr_accessor :vmware

          DEFAULT = {}

          def initialize(vmware)
            @vmware = Provider.validate_base(vmware)
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
