module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Generate

        def initialize(app, env)
          @app = app
          @env = env

          @logger = Log4r::Logger.new('vagrant::invade::action::generate')
        end

        def call(env)

          @app.call(env)
        end

        def process(part_name, part_data, generator_type)
          generator = Generator.new(@env)

          generator.type = generator_type
          generator.generate(part_name, part_data)
        end

      end
    end
  end
end
