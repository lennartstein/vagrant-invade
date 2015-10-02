module VagrantPlugins
  module Invade
    module Validator
      module Plugin

        class WinNFSd

          attr_accessor :env
          attr_accessor :win_nfsd

          DEFAULT = {
            'enabled' => true,
            'logging' => false,
            'uid' => Process.uid,
            'guid' => Process.gid
          }

          def initialize(env, win_nfsd)
            @env = env
            @win_nfsd = win_nfsd
          end

          def validate
            return nil unless @win_nfsd

            # ENABLED
            @win_nfsd['enabled'] = Validator.validate(
              @win_nfsd['enabled'], 'enabled', 'boolean', DEFAULT['enabled']
            )

            # LOGGING (activate the logging of the NFS daemon which will show the daemon window in the foreground)
            @win_nfsd['logging'] = Validator.validate(
              @win_nfsd['logging'], 'logging', 'boolean', DEFAULT['logging']
            )

            # User ID
            @win_nfsd['uid'] = Validator.validate(
              @win_nfsd['uid'], 'uid', 'boolean', DEFAULT['uid']
            )

            # Group ID
            @win_nfsd['guid'] = Validator.validate(
              @win_nfsd['guid'], 'guid', 'integer', DEFAULT['guid']
            )

            @win_nfsd
          end
        end
      end
    end
  end
end
