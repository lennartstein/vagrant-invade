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
      end
    end
  end
end
