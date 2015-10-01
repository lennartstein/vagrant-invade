module VagrantPlugins
  module Invade
    module Validator
      module SyncedFolder

        autoload :VB, 'vagrant-invade/validator/synced_folder/vb'
        autoload :NFS, 'vagrant-invade/validator/synced_folder/nfs'

        attr_accessor :env
        attr_accessor :shared_folder

        DEFAULT = {
          'enabled' => nil,
          'source' => '.',
          'path' => '/www'
        }

        def self.validate_base(env, shared_folder)
          return nil unless @shared_folder

          @shared_folder['enabled'] = Validator.validate(
            @shared_folder['enabled'], 'enabled', 'string', DEFAULT['enabled']
          )

          @shared_folder['source'] = Validator.validate(
            @shared_folder['source'], 'source', 'string', DEFAULT['source']
          )

          @shared_folder['path'] = Validator.validate(
            @shared_folder['path'], 'path', 'string', DEFAULT['path']
          )

          @shared_folder
        end

      end
    end
  end
end
