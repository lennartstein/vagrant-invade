module VagrantPlugins
  module Invade
    module Generator
      module Section

        autoload :Box, 'vagrant-invade/generator/section/box'
        autoload :Network, 'vagrant-invade/generator/section/network'
        autoload :Provider, 'vagrant-invade/generator/section/provider'
        autoload :SyncedFolder, 'vagrant-invade/generator/section/synced_folder'
        autoload :Provision, 'vagrant-invade/generator/section/provision'

      end
    end
  end
end
