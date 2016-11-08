module VagrantPlugins
  module Invade
    module Module
      module SyncedFolder

        autoload :NFS, 'vagrant-invade/module/synced_folder/nfs/nfs'
        autoload :VB, 'vagrant-invade/module/synced_folder/vb/vb'

      end
    end
  end
end
