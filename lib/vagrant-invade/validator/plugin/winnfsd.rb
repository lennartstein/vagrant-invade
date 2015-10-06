module VagrantPlugins
  module Invade
    module Validator
      module Plugin

        class WinNFSd

          attr_accessor :env
          attr_accessor :winnfsd

          DEFAULT = {
            'enabled' => true,
            'logging' => false,
            'uid' => Process.uid,
            'guid' => Process.gid
          }

          def initialize(env, winnfsd)
            @env = env
            @winnfsd = winnfsd
          end

          def validate
            return nil unless @winnfsd

            # ENABLED
            @winnfsd['enabled'] = Validator.validate_boolean(
              @winnfsd['enabled'], 'enabled', DEFAULT['enabled']
            )

            # LOGGING (activate the logging of the NFS daemon which will show the daemon window in the foreground)
            @winnfsd['logging'] = Validator.validate_boolean(
              @winnfsd['logging'], 'logging', DEFAULT['logging']
            )

            # User ID
            @winnfsd['uid'] = Validator.validate_integer(
              @winnfsd['uid'], 'uid', DEFAULT['uid']
            )

            # Group ID
            @winnfsd['guid'] = Validator.validate_integer(
              @winnfsd['guid'], 'guid', DEFAULT['guid']
            )

            @winnfsd
          end
        end
      end
    end
  end
end
