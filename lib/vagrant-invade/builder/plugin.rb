module VagrantPlugins
  module Invade
    module Builder
      module Plugin

        autoload :HostManager, 'vagrant-invade/builder/plugin/hostmanager'
        autoload :WinNFSd, 'vagrant-invade/builder/plugin/winnfsd'
        autoload :R10k, 'vagrant-invade/builder/plugin/r10k'

      end
    end
  end
end
