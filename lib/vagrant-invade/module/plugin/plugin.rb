module VagrantPlugins
  module Invade
    module InvadeModule
      module Plugin

        autoload :Hostmanager, 'vagrant-invade/module/plugin/hostmanager/hostmanager'
        autoload :WinNFSd, 'vagrant-invade/module/plugin/winnfsd/winnfsd'
        autoload :R10k, 'vagrant-invade/module/plugin/r10k/r10k'

      end
    end
  end
end
