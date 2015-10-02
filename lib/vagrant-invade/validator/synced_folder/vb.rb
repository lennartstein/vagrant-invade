module VagrantPlugins
  module Invade
    module Validator
      module SyncedFolder

        class Vb

          attr_accessor :env
          attr_accessor :vb

          DEFAULT = {
            'owner' => 'vagrant',
            'group' => 'root',
            'dmode' => 755,
            'fmode' => 664
          }

          def initialize(env, vb)
            @env = env
            @vb = SyncedFolder.validate_base(env, vb)
          end

          def validate
            return false unless @vb

            # OWNER
            @vb['owner'] = Validator.validate(
              @vb['owner'], 'owner', 'string', DEFAULT['owner']
            )

            # GROUP
            @vb['group'] = Validator.validate(
              @vb['group'], 'group', 'string', DEFAULT['group']
            )

            # DMODE (Directory Permission Mode)
            @vb['dmode'] = Validator.validat(
              @vb['dmode'], 'dmode', 'integer', DEFAULT['dmode']
            )

            # FMODE (File Permission Mode)
            @vb['fmode'] = Validator.validate(
              @vb['fmode'], 'fmode', 'integer', "#{DEFAULT['fmode']}"
            )

            @vb
          end
        end
      end
    end
  end
end
