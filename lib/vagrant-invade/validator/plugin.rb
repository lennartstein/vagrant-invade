module VagrantPlugins
  module Invade
    module Validator
      module Plugin

        autoload :HostManager, 'vagrant-invade/validator/provider/virtualbox'
        autoload :WinNFSD, 'vagrant-invade/validator/provider/vmware'

      end
    end
  end
end
