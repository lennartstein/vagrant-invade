module VagrantPlugins
  module Invade
    module Validator

      class SSH

        attr_accessor :env
        attr_accessor :ssh

        DEFAULT = {
          'enabled' => nil,
          'path' => '~/.ssh/'
        }

        def initialize(env, ssh)
          @env = env
          @ssh = ssh
        end

        def validate
          return DEFAULT unless @ssh

          @ssh['enabled'] = Validator.validate(@ssh['enabled'], 'enabled', 'string', DEFAULT['enabled'])
          @ssh['path'] = Validator.validate(@ssh['path'], 'path', 'string', DEFAULT['path'])

          @ssh
        end

      end
    end
  end
end
