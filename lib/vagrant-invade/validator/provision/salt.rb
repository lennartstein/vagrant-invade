require 'rbconfig'

module VagrantPlugins
  module Invade
    module Validator
      module Provision

        # (see: https://www.vagrantup.com/docs/provisioning/salt.html)
        class Salt

          attr_accessor :env
          attr_accessor :salt

          DEFAULT = {
              # install options
              :install_master => nil,
              :no_minion => false,
              :install_syncdir => false,
              :install_type => 'stable',
              :install_args => 'dev',
              :always_install => false,
              :bootstrap_script => nil,
              :bootstrap_options => nil,
              :version => nil,

              # minion options
              :minion_config => nil,
              :minion_key => nil,
              :minion_id => nil,
              :minion_pub => nil,
              :grains_config => nil,
              :masterless => nil,

              # master options
              :master_config => nil,
              :master_key => nil,
              :master_pub => nil,
              :seed_master => nil,
          }

          def initialize(env, salt)
            @env = env
            @salt = salt
            @invade = env[:invade]
          end

          def validate
            return nil unless @salt

            # INSTALL OPTIONS
            @salt['install_master'] = Validator.validate_boolean(
                @salt['install_master'], 'install_master', DEFAULT['install_master']
            )

            @salt['no_minion'] = Validator.validate_boolean(
                @salt['no_minion'], 'no_minion', DEFAULT['no_minion']
            )

            @salt['install_syncdir'] = Validator.validate_boolean(
                @salt['install_syncdir'], 'install_syncdir', DEFAULT['install_syncdir']
            )

            @salt['install_type'] = Validator.validate_string(
                @salt['install_type'], 'install_type', DEFAULT['install_type']
            )

            @salt['install_args'] = Validator.validate_string(
                @salt['install_args'], 'install_args', DEFAULT['install_args']
            )

            @salt['always_install'] = Validator.validate_bool(
                @salt['always_install'], 'always_install', DEFAULT['always_install']
            )

            @salt['bootstrap_script'] = Validator.validate_string(
                @salt['bootstrap_script'], 'bootstrap_script', DEFAULT['bootstrap_script']
            )

            @salt['bootstrap_options'] = Validator.validate_string(
                @salt['bootstrap_options'], 'bootstrap_options', DEFAULT['bootstrap_options']
            )

            @salt['version'] = Validator.validate_string(
                @salt['version'], 'version', DEFAULT['version']
            )

            # MINION OPTIONS
            @salt['minion_config'] = Validator.validate_string(
                @salt['minion_config'], 'minion_config', DEFAULT['minion_config']
            )

            @salt['minion_key'] = Validator.validate_string(
                @salt['minion_key'], 'minion_key', DEFAULT['minion_key']
            )

            @salt['minion_id'] = Validator.validate_string(
                @salt['minion_id'], 'minion_id', DEFAULT['minion_id']
            )

            @salt['minion_pub'] = Validator.validate_string(
                @salt['minion_pub'], 'minion_pub', DEFAULT['minion_pub']
            )

            @salt['grains_config'] = Validator.validate_string(
                @salt['grains_config'], 'grains_config', DEFAULT['grains_config']
            )

            @salt['masterless'] = Validator.validate_boolean(
                @salt['masterless'], 'masterless', DEFAULT['masterless']
            )

            # MASTER OPTIONS
            @salt['master_config'] = Validator.validate_string(
                @salt['master_config'], 'master_config', DEFAULT['master_config']
            )

            @salt['master_key'] = Validator.validate_string(
                @salt['master_key'], 'master_key', DEFAULT['master_key']
            )

            @salt['master_pub'] = Validator.validate_string(
                @salt['master_pub'], 'master_pub', DEFAULT['master_pub']
            )

            @salt['seed_master'] = Validator.validate_string(
                @salt['seed_master'], 'seed_master', DEFAULT['seed_master']
            )

            @salt
          end
        end
      end
    end
  end
end
