module VagrantPlugins
  module Invade
    module Validator
      module Plugin

        autoload :HostManager, 'vagrant-invade/validator/plugin/hostmanager'
        autoload :WinNFSd, 'vagrant-invade/validator/plugin/winnfsd'
        autoload :R10k, 'vagrant-invade/validator/plugin/r10k'

      end
    end
  end
end
