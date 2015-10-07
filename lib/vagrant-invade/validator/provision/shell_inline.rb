module VagrantPlugins
  module Invade
    module Validator
      module Provision

        class ShellInline

          attr_accessor :env
          attr_accessor :shell_inline

          DEFAULT = {
            'name' => 'invade_shell_inline',
            'inline' => nil,
            'binary' => nil, # Vagrant default is true
            'privileged' => nil # Vagrant default is true
          }

          def initialize(env, shell_inline)
            @env = env
            @shell_inline = Provision.validate_base(env, shell_inline)
          end

          def validate
            return nil unless @shell_inline

            # NAME
            @shell_inline['name'] = Validator.validate_string(
              @shell_inline['name'], 'name', DEFAULT['name']
            )

            # INLINE SCRIPT
            @shell_inline['inline'] = Validator.validate_string(
              @shell_inline['inline'], 'inline', DEFAULT['inline']
            )

            # BINARY (replace windows newline endings with unix line endings)
            @shell_inline['binary'] = Validator.validate_boolean(
              @shell_inline['binary'], 'binary', DEFAULT['binary']
            )

            # PRIVILEGED (run with sudo)
            @shell_inline['privileged'] = Validator.validate_boolean(
              @shell_inline['privileged'], 'privileged', DEFAULT['privileged']
            )

            @shell_inline
          end
        end
      end
    end
  end
end
