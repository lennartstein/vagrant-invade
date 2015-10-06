module VagrantPlugins
  module Invade
    module Validator
      module Plugin

        autoload :HostManager, 'vagrant-invade/validator/plugin/hostmanager'
        autoload :WinNFSd, 'vagrant-invade/validator/plugin/winnfsd'

      end
    end
  end
end
