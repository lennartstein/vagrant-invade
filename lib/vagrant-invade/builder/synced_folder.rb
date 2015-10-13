module VagrantPlugins
  module Invade
    module Builder
      module SyncedFolder

        autoload :VirtualBox, 'vagrant-invade/builder/synced_folder/virtualbox'
        autoload :NFS, 'vagrant-invade/builder/synced_folder/nfs'

      end
    end
  end
end
