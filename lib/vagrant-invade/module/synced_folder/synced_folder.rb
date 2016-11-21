module VagrantPlugins
  module Invade
    module InvadeModule
      module SyncedFolder

        autoload :Nfs, 'vagrant-invade/module/synced_folder/nfs/nfs'
        autoload :Vb, 'vagrant-invade/module/synced_folder/vb/vb'

      end
    end
  end
end
