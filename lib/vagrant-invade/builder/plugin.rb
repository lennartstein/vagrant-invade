module VagrantPlugins
  module Invade
    module Builder
      module Plugin

        autoload :HostManager, 'vagrant-invade/builder/plugin/hostmanager.rb'
        autoload :WinNFSd, 'vagrant-invade/builder/plugin/winnfsd.rb'

      end
    end
  end
end
