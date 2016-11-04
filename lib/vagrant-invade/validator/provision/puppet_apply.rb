require 'rbconfig'

module VagrantPlugins
  module Invade
    module Validator
      module Provision

        # (see: https://docs.vagrantup.com/v2/provisioning/puppet_apply.html)
        class PuppetApply

          attr_accessor :puppet_apply

          DEFAULT = {
            'module_path' => '.puppet/modules',
            'manifests_path' => './puppet/manifests',
            'manifest_file' => 'init.pp',
            'hiera_config_path' => nil,
            'facter' => {}
          }

          def initialize(env, puppet_apply)
            @env = env
            @puppet_apply = puppet_apply
            @invade = env[:invade]
          end

          def validate
            return nil unless @puppet_apply

            # MODULES PATH
            @puppet_apply['module_path'] = Validator.validate_string_or_array(
              @puppet_apply['module_path'], 'module_path', DEFAULT['module_path']
            )

            # MANIFESTS PATH
            @puppet_apply['manifests_path'] = Validator.validate_string(
              @puppet_apply['manifests_path'], 'manifests_path', DEFAULT['manifests_path']
            )

            # MANIFEST FILE
            @puppet_apply['manifest_file'] = Validator.validate_string(
              @puppet_apply['manifest_file'], 'manifest_file', DEFAULT['manifest_file']
            )

            # HIERA CONFIG PATH
            @puppet_apply['hiera_config_path'] = Validator.validate_string(
              @puppet_apply['hiera_config_path'], 'hiera_config_path', DEFAULT['hiera_config_path']
            )

            # FACTER
            @puppet_apply['facter'] = Validator.validate_hash(
              @puppet_apply['facter'], 'facter', DEFAULT['facter']
            )

            @puppet_apply
          end
        end
      end
    end
  end
end
