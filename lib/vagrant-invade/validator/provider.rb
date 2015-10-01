module VagrantPlugins
  module Invade
    module Validator
      module Provider

        autoload :VirtualBox, 'vagrant-invade/validator/provider/virtualbox'
        autoload :VMware, 'vagrant-invade/validator/provider/vmware'

        attr_accessor :env
        attr_accessor :provider

        DEFAULT = {
          'name' => nil,
          'core' => 1,
          'memory' => 1024
        }

        def self.validate_base(env, provider)
          return nil unless @provider

          # NAME
          @provider['name'] = Validator.validate(
            @provider['name'], 'name', 'string', DEFAULT['name']
          )

          # CORE
          @provider['cores'] = Validator.validate(
            @provider['cores'], 'cores', 'integer', "#{DEFAULT['cores']}"
          )

          # MEMORY
          @provider['memory'] = Validator.validate(
            @provider['memory'], 'memory', 'integer', "#{DEFAULT['memory']}"
          )

          @provider
        end

      end
    end
  end
end
