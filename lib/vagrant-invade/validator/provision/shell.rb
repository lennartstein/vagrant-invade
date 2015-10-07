module VagrantPlugins
  module Invade
    module Validator
      module Provision

        class Shell

          attr_accessor :env
          attr_accessor :shell

          DEFAULT = {
            'name' => 'invade_shell',
            'path' => nil,
            'binary' => nil, # Vagrant default is true
            'privileged' => nil # Vagrant default is true
          }

          def initialize(env, shell)
            @env = env
            @shell = Provision.validate_base(env, shell)
          end

          def validate
            return nil unless @shell

            # NAME
            @shell['name'] = Validator.validate_string(
              @shell['name'], 'name', DEFAULT['name']
            )

            # PATH (path to shell script or remote address to script file)
            @shell['path'] = Validator.validate_string(
              @shell['path'], 'path', DEFAULT['path']
            )

            # BINARY (replace windows newline endings with unix line endings)
            @shell['binary'] = Validator.validate_boolean(
              @shell['binary'], 'binary', DEFAULT['binary']
            )

            # PRIVILEGED (run with sudo)
            @shell['privileged'] = Validator.validate_boolean(
              @shell['privileged'], 'privileged', DEFAULT['privileged']
            )

            @shell
          end
        end
      end
    end
  end
end
