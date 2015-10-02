module VagrantPlugins
  module Invade
    module Validator
      module Plugin

        autoload :HostManager, 'vagrant-invade/validator/provider/hostmanager'
        autoload :WinNFSd, 'vagrant-invade/validator/provider/winnfsd'

      end
    end
  end
end
