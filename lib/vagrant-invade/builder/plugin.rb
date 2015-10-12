module VagrantPlugins
  module Invade
    module Builder
      module Plugin

        autoload :HostManager, 'vagrant-invade/builder/plugin/hostmanager.rb'
        autoload :WinNFSd, 'vagrant-invade/builder/plugin/winnfsd.rb'
        autoload :R10k, 'vagrant-invade/builder/plugin/r10k.rb'

      end
    end
  end
end
