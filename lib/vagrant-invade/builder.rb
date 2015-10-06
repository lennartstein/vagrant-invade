module VagrantPlugins
  module Invade
    module Builder

      autoload :Box, 'vagrant-invade/builder/box'
      autoload :Network, 'vagrant-invade/builder/network'
      autoload :Provider, 'vagrant-invade/builder/provider'
      autoload :SyncedFolder, 'vagrant-invade/builder/synced_folder'
      autoload :Definition, 'vagrant-invade/builder/definition'
      autoload :Vagrantfile, 'vagrant-invade/builder/vagrantfile'

      TEMPLATE_PATH = File.join(File.dirname(__FILE__), 'template')

    end
  end
end
