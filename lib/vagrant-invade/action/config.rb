require 'vagrant-invade/version'

module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Config

        def initialize(app, env)
          @app = app
          @env = env

          @logger = Log4r::Logger.new('vagrant::invade::action::config')
          @dir = Dir.pwd
        end

        def call(env)

          config_file_path = "#{@dir}/invade.yml"

          # Returns with invade in environment if Invade Configuration file already exists
          if File.exist?(config_file_path)
            @logger.debug 'Config file found. Proceed.'
            @env[:ui].info "[Invade] Using Plugin vagrant-invade-#{VERSION} to build a Vagrantfile."

            # Add invade configuration as global environment variable since we know configuration file exists
            env[:invade] = Invade.get_invade_config
            unless env[:invade]
              raise 'Something went wrong. Configuration file could not be loaded.'
            end
          else
            @env[:ui].info "[Invade] 'invade.yml' not exists. You forgot to 'vagrant invade init'?"
            exit
          end

          @app.call(env)
        end

      end

    end
  end
end
