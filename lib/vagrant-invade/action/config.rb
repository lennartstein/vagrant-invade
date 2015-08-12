module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Config

        ACTION = 'CONFIG'

        def initialize(app, env)
          @app = app
          @env = env
          @logger = Log4r::Logger.new('vagrant::invade::action::config')
        end

        def call(env)
          root_path = @env[:root_path]
          config_file_path = "#{root_path}/InvadeConfig.yaml"
          template_file_path = config_file_path + '.dist'
          default_config_file_path = Dir.pwd + '/InvadeConfig.yaml.dist'

          # Return here if Invade Configuration file already exists
          if File.exist?(config_file_path)
            @logger.debug 'Config file found. Proceed.'
            @env[:ui].info "[INVADE] Using Plugin vagrant-invade-#{VagrantPlugins::Invade::VERSION} to setup Vagrant!"

            @app.call(env)
            return
          else
            # Try to copy template path from vagrant repository of project.
            begin
              FileUtils.cp(template_file_path, config_file_path)
              @logger.debug 'Config file could not be found. Copied template file.'
              @env[:ui].debug '[INVADE] Configuration file could not be found.'
              @env[:ui].debug "[INVADE] Template file \"#{template_file_path}\" copied to \"#{config_file_path}\"."
            rescue
              # If not found default invade configuration file will be copied.
              FileUtils.cp(default_config_file_path, config_file_path)
              @logger.info 'Template file could not be found. Copied default invade configuration file.'
              @env[:ui].warn '[INVADE] Template file could not be found.'
              @env[:ui].warn "[INVADE] Default file \"#{template_file_path}\" copied to \"#{config_file_path}\"."
              @env[:ui].warn '[INVADE] Please update the configuration file and do a "vagrant up" again!'
            end
          end

          @app.call(env)
        end
      end

    end
  end
end
