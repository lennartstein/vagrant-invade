module VagrantPlugins
  module Invade
    module Generator
      module Section

        autoload :VM, 'vagrant-invade/generator/section/vm'
        autoload :Network, 'vagrant-invade/generator/section/network'
        autoload :Provider, 'vagrant-invade/generator/section/provider'
        autoload :SyncedFolder, 'vagrant-invade/generator/section/synced_folder'
        autoload :Provision, 'vagrant-invade/generator/section/provision'
        autoload :Plugin, 'vagrant-invade/generator/section/plugin'

      end
    end
  end
end
