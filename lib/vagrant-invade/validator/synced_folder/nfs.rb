module VagrantPlugins
  module Invade
    module Validator
      module SyncedFolder

        class NFS

          attr_accessor :env
          attr_accessor :nfs

          DEFAULT = {
            'uid' => nil,
            'gid' => nil,
            'mount_options' => ['nolock']
          }

          def initialize(env, nfs)
            @env = env
            @nfs = SyncedFolder.validate_base(env, nfs)
          end

          def validate
            return nil unless @nfs

            # USER ID
            @nfs['uid'] = Validator.validate_integer(
              @nfs['uid'], 'uid', DEFAULT['uid']
            )

            # GROUP ID
            @nfs['gid'] = Validator.validate_integer(
              @nfs['gid'], 'gid', DEFAULT['gid']
            )

            # NFS OPTIONS
            @nfs['mount_options'] = Validator.validate_array(
              @nfs['mount_options'], 'mount_options', DEFAULT['mount_options']
            )

            @nfs
          end
        end
      end
    end
  end
end
