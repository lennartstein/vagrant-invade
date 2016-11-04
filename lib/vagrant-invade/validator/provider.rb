module VagrantPlugins
  module Invade
    module Validator
      module Provider

        autoload :VirtualBox, 'vagrant-invade/validator/provider/virtualbox'
        autoload :VMware, 'vagrant-invade/validator/provider/vmware'

        DEFAULT = {
          'name' => nil,
          'core' => 1,
          'memory' => 1024
        }

        def self.validate_base(provider)
          return nil unless provider

          # NAME
          provider['name'] = Validator.validate_string(
            provider['name'], 'name', DEFAULT['name']
          )

          # CORE
          provider['cores'] = Validator.validate_integer(
            provider['cores'], 'cores', DEFAULT['cores']
          )

          # MEMORY
          provider['memory'] = Validator.validate_integer(
            provider['memory'], 'memory', DEFAULT['memory']
          )

          provider
        end

      end
    end
  end
end
