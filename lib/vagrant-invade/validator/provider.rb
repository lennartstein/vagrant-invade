module VagrantPlugins
  module Invade
    module Validator
      module Provider

        autoload :VirtualBox, 'vagrant-invade/validator/provider/virtualbox'
        autoload :VMWare, 'vagrant-invade/validator/provider/vmware'

      end
    end
  end
end
