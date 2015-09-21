module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin
      include VagrantPlugins::Invade::Generator

      class Generate

        def initialize(app, env)
          @app = app
          @env = env
          @invade = env[:invade]
          @logger = Log4r::Logger.new('vagrant::invade::action::generate')
        end

        def call(env)
          box('test', 'http://google.de')

          @app.call(env)
        end

        private

        def box(name, url)
          require 'vagrant-invade/generator/box'

          options = Hash.new
          options['name'] = 'test/test1'
          options['url'] = 'https://google.com/test1'

          box = Generator::Box.new(@env[:ui], options)
          box.build

          puts box.result
        end
      end
    end
  end
end
