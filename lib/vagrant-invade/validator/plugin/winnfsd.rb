module VagrantPlugins
  module Invade
    module Validator
      module Plugin

        class WinNFSd

          attr_accessor :env
          attr_accessor :winnfsd

          DEFAULT = {
            'logging' => false,
            'uid' => nil,
            'guid' => nil
          }

          def initialize(env, winnfsd)
            @env = env
            @winnfsd = winnfsd
          end

          def validate
            return nil unless @winnfsd

            # LOGGING (activate the logging of the NFS daemon which will show the daemon window in the foreground)
            @winnfsd['logging'] = Validator.validate_boolean(
              @winnfsd['logging'], 'logging', DEFAULT['logging']
            )

            # User ID
            @winnfsd['uid'] = Validator.validate_integer(
              @winnfsd['uid'], 'uid', DEFAULT['uid']
            )

            # Group ID
            @winnfsd['gid'] = Validator.validate_integer(
              @winnfsd['gid'], 'gid', DEFAULT['gid']
            )

            @winnfsd
          end
        end
      end
    end
  end
end
