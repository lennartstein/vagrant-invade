module VagrantPlugins
  module Invade
    module Validator
      module Plugin

        class R10k

          attr_accessor :env
          attr_accessor :r10k

          DEFAULT = {
            'enabled' => false,
            'puppet_dir' => nil,
            'puppetfile_path' => nil,
            'module_path' => nil,
            'modules' => nil
          }

          def initialize(env, r10k)
            @env = env
            @r10k = r10k
          end

          def validate
            return nil unless @r10k

            @r10k['enabled'] =  Validator.validate_boolean(
              @r10k['enabled'], 'enabled', DEFAULT['enabled']
            )

            @r10k['puppet_dir'] =  Validator.validate_string(
              @r10k['puppet_dir'], 'puppet_dir', DEFAULT['puppet_dir']
            )

            @r10k['puppetfile_path'] =  Validator.validate_string(
              @r10k['puppetfile_path'], 'puppetfile_path', DEFAULT['puppetfile_path']
            )

            @r10k['module_path'] =  Validator.validate_string(
              @r10k['module_path'], 'module_path', DEFAULT['module_path']
            )

            @r10k['modules'] =  Validator.validate_hash(
              @r10k['modules'], 'modules', DEFAULT['modules']
            )

            @r10k
          end
        end
      end
    end
  end
end
