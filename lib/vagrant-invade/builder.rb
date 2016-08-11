module VagrantPlugins
  module Invade
    module Builder

      autoload :HostManager, 'vagrant-invade/builder/hostmanager'
      autoload :VM, 'vagrant-invade/builder/vm'
      autoload :Network, 'vagrant-invade/builder/network'
      autoload :SSH, 'vagrant-invade/builder/ssh'
      autoload :Provider, 'vagrant-invade/builder/provider'
      autoload :Provision, 'vagrant-invade/builder/provision'
      autoload :SyncedFolder, 'vagrant-invade/builder/synced_folder'
      autoload :Plugin, 'vagrant-invade/builder/plugin'
      autoload :Machine, 'vagrant-invade/builder/machine'
      autoload :Vagrantfile, 'vagrant-invade/builder/vagrantfile'

      TEMPLATE_PATH = File.join(File.dirname(__FILE__), 'template')

    end
  end
end
