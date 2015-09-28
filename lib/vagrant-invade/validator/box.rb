module VagrantPlugins
  module Invade
    module Validator

      class Box

        attr_accessor :env
        attr_accessor :box

        DEFAULT = {
          'name' => 'invade/default',
          'url' => nil
        }

        def initialize(env, box)
          @env = env
          @box = box
        end

        def validate
          return DEFAULT unless @box

          @box['name'] = Validator.validate(@box['name'], 'name', 'string', DEFAULT['name'])
          @box['url'] = Validator.validate(@box['url'], 'url', 'string', DEFAULT['url'])

          @box
        end

      end
    end
  end
end
