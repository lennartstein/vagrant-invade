module VagrantPlugins
  module Invade
    module InvadeModule

      autoload :Hostmanager, 'vagrant-invade/module/hostmanager/hostmanager'
      autoload :Network, 'vagrant-invade/module/network/network'
      autoload :Nfs, 'vagrant-invade/module/nfs/nfs'
      autoload :Plugin, 'vagrant-invade/module/plugin/plugin'
      autoload :Provider, 'vagrant-invade/module/provider/provider'
      autoload :Provision, 'vagrant-invade/module/provision/provision'
      autoload :Ssh, 'vagrant-invade/module/ssh/ssh'
      autoload :SyncedFolder, 'vagrant-invade/module/synced_folder/synced_folder'
      autoload :Vagrant, 'vagrant-invade/module/vagrant/vagrant'
      autoload :Vm, 'vagrant-invade/module/vm/vm'

      class InvadeModule
        require 'erubis'

        def get_template_path(module_file_path)
          File.join(File.dirname(module_file_path), 'template.erb')
        end
      end

    end
  end
end
