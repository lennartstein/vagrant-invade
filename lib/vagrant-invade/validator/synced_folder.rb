module VagrantPlugins
  module Invade
    module Validator
      module SyncedFolder

        autoload :VB, 'vagrant-invade/validator/synced_folder/vb'
        autoload :NFS, 'vagrant-invade/validator/synced_folder/nfs'

        DEFAULT = {
          'enabled' => nil,
          'source' => '.',
          'path' => '/www'
        }

        def self.validate_base(env, shared_folder)
          return nil unless shared_folder

          shared_folder['enabled'] = Validator.validate_boolean(
            shared_folder['enabled'], 'enabled', DEFAULT['enabled']
          )

          shared_folder['source'] = Validator.validate_string(
            shared_folder['source'], 'source', DEFAULT['source']
          )

          shared_folder['path'] = Validator.validate_string(
            shared_folder['path'], 'path', DEFAULT['path']
          )

          shared_folder
        end

      end
    end
  end
end
