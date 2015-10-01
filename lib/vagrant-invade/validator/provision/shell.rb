module VagrantPlugins
  module Invade
    module Validator
      module Provision

        class Shell

          attr_accessor :env
          attr_accessor :shell

          DEFAULT = {
            'name' => 'invade_shell_provision',
            'inline' => nil,
            'path' => nil,
            'binary' => nil,
            'privileged' => nil
          }

          def initialize(env, shell)
            @env = env
            @shell = Provision.validate_base(env, shell)
          end

          def validate
            return nil unless shell

            # NAME
            @shell['name'] = Validator.validate(
              @shell['name'], 'name', 'string', DEFAULT['name']
            )

            # INLINE SCRIPT
            @shell['inline'] = Validator.validate(
              @shell['inline'], 'inline', 'string', DEFAULT['inline']
            )

            # PATH (path to shell script or remote address to script file)
            @shell['path'] = Validator.validate(
              @shell['path'], 'path', 'string', DEFAULT['path']
            )

            # BINARY (replace windows newline endings with unix line endings)
            @shell['binary'] = Validator.validate(
              @shell['binary'], 'binary', 'boolean', DEFAULT['binary']
            )

            # PRIVILEGED (run with sudo)
            @shell['privileged'] = Validator.validate(
              @shell['privileged'], 'privileged', 'boolean', DEFAULT['privileged']
            )

          end
        end
      end
    end
  end
end
