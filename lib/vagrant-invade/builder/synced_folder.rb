module VagrantPlugins
  module Invade
    module Builder
      module SyncedFolder

        autoload :VirtualBox, 'vagrant-invade/builder/synced_folder/virtualbox.rb'
        autoload :NFS, 'vagrant-invade/builder/synced_folder/nfs.rb'

      end
    end
  end
end
