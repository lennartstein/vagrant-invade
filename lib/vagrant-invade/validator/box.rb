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

          # BOX NAME (usually repository name of box on Atlas (http://atlas.hashicorp.com))
          @box['name'] = Validator.validate_string(
            @box['name'], 'name', DEFAULT['name']
          )

          # BOX URL
          @box['url'] = Validator.validate_string(
            @box['url'], 'url', DEFAULT['url']
          )

          @box
        end

      end
    end
  end
end
