module VagrantPlugins
  module Invade
    module Validator
      module Provision

        class Puppet

          attr_accessor :env
          attr_accessor :puppet

          DEFAULT = {
            'folder' => './puppet',
            'modules' => 'modules',
            'manifests' => 'manifests',
            'manifest_file' => 'init.pp',
            'hiera_config_path' => nil,
            'facter' => nil
          }

          def initialize(env, puppet)
            @env = env
            @puppet = Provision.validate_base(env, puppet)
          end

          def validate
            return nil unless puppet

            # FOLDER
            @puppet['folder'] = Validator.validate(
              @puppet['folder'], 'folder', 'string', DEFAULT['folder']
            )

            # MODULES PATH
            @puppet['modules_path'] = Validator.validate(
              @puppet['modules_path'], 'modules_path', 'string', DEFAULT['modules_path']
            )

            # MANIFESTS PATH
            @puppet['manifests_path'] = Validator.validate(
              @puppet['manifests_path'], 'manifests_path', 'string', DEFAULT['manifests_path']
            )

            # MANIFEST FILE
            @puppet['manifest_file'] = Validator.validate(
              @puppet['manifest_file'], 'manifest_file', 'string', DEFAULT['manifest_file']
            )

            # HIERA CONFIG PATH
            @puppet['hiera_config_path'] = Validator.validate(
              @puppet['hiera_config_path'], 'hiera_config_path', 'string', DEFAULT['hiera_config_path']
            )

            # FACTER
            @puppet['facter'] = Validator.validate(
              @puppet['facter'], 'facter', 'string', DEFAULT['facter']
            )

          end
        end
      end
    end
  end
end
