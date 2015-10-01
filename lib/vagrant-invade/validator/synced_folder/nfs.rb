module VagrantPlugins
  module Invade
    module Validator
      module SyncedFolder

        class NFS

          attr_accessor :env
          attr_accessor :nfs

          DEFAULT = {
            'uid' => Process.uid,
            'gid' => Process.gid,
            'options' => ['nolock']
          }

          def initialize(env, nfs)
            @env = env
            @nfs = SyncedFolder.validate_base(env, nfs)
          end

          def validate
            return nil unless nfs

            # USER ID
            @nfs['uid'] = Validator.validate(
              @nfs['uid'], 'uid', 'array', DEFAULT['uid']
            )

            # GROUP ID
            @nfs['gid'] = Validator.validate(
              @nfs['gid'], 'gid', 'array', DEFAULT['gid']
            )

            # NFS OPTIONS
            @nfs['options'] = Validator.validate(
              @nfs['options'], 'options', 'array', DEFAULT['options']
            )

          end
        end
      end
    end
  end
end
