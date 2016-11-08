module VagrantPlugins
  module Invade
    module InvadeModule

      autoload :Hostmanager, 'vagrant-invade/module/hostmanager/hostmanager'
      autoload :Network, 'vagrant-invade/module/network/network'
      autoload :Plugin, 'vagrant-invade/module/plugin/plugin'
      autoload :Provider, 'vagrant-invade/module/provider/provider'
      autoload :Provision, 'vagrant-invade/module/provision/provision'
      autoload :Ssh, 'vagrant-invade/module/ssh/ssh'
      autoload :SyncedFolder, 'vagrant-invade/module/synced_folder/synced_folder'
      autoload :Vm, 'vagrant-invade/module/vm/vm'

      class InvadeModule
        require 'erubis'

        TEMPLATE_PATH = File.join(File.dirname(__FILE__), 'template')

      end

    end
  end
end
