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
            'options' => ['nolock']
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
            @nfs['options'] = Validator.validate_array(
              @nfs['options'], 'options', DEFAULT['options']
            )

            @nfs
          end
        end
      end
    end
  end
end
