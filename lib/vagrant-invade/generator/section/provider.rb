module VagrantPlugins
  module Invade
    module Generator
      module Section

        class Provider

          attr_accessor :machine_name, :type, :provider_data

          def initialize(machine_name, type, provider_data)
            @machine_name = machine_name
            @type = type
            @provider_data = provider_data
          end

          def generate
            case @type
            when 'virtualbox'
              provider = Builder::Provider::VirtualBox.new(@machine_name, @provider_data)
            when 'vmware'
              provider = Builder::Provider::VMware.new(@machine_name, @provider_data)
            else
              raise StandardError, "Provider unknown or not set. Please check the provider configuration."
            end

            provider.build

            provider.result
          end

        end

      end
    end
  end
end
