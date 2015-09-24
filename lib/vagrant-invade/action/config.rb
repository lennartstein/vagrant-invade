module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Config

        def initialize(app, env)
          @app = app
          @env = env
          @logger = Log4r::Logger.new('vagrant::invade::action::config')
        end

        def call(env)
          root_path = @env[:root_path]
          config_file_path = "#{root_path}/InvadeConfig.yml"
          template_file_path = config_file_path + '.dist'
          default_config_file_path = Dir.pwd + '/InvadeConfig.yml.dist'

          # Returns with invade in environment if Invade Configuration file already exists
          if File.exist?(config_file_path)
            @logger.debug 'Config file found. Proceed.'
            @env[:ui].info "[Invade] Using Plugin vagrant-invade-#{VagrantPlugins::Invade::VERSION} to setup Vagrant!"

            # Add invade configuration as global environment variable since we know configuration file exists
            env[:invade] = VagrantPlugins::Invade.get_invade_config()

            # Its necessary to invoke a call with the environment for not loosing the invade data
            @app.call(env)
          else
            # Try to copy template path from vagrant repository of project.
            begin
              FileUtils.cp(template_file_path, config_file_path)
              @logger.debug 'Config file could not be found. Copied template file.'
              @env[:ui].debug '[Invade] Configuration file could not be found.'
              @env[:ui].warn '[Invade] Copying template configuration...'
              @env[:ui].warn "\tFrom: \"#{template_file_path}\""
              @env[:ui].warn "\tTo: \"#{config_file_path}\""
              sleep 2
              @env[:ui].warn '[Invade] Restarting vagrant...'
              sleep 3
              if !Vagrant.in_installer? && !Vagrant.very_quiet?
                Kernel.exec('bundle exec vagrant up')
              else
                Kernel.exec('vagrant up')
              end
            rescue
              # If not found default invade configuration file will be copied.
              FileUtils.cp(default_config_file_path, config_file_path)
              @logger.info 'Template file could not be found. Copied default invade configuration file.'
              @env[:ui].warn '[Invade] Template file could not be found.'
              @env[:ui].warn '[Invade] Copying default configuration...'
              @env[:ui].warn "\tFrom: \"#{template_file_path}\""
              @env[:ui].warn "\tTo: \"#{config_file_path}\""
              sleep 2
              @env[:ui].warn '[Invade] Restarting vagrant...'
              sleep 3
              if !Vagrant.in_installer? && !Vagrant.very_quiet?
                Kernel.exec('bundle exec vagrant up')
              else
                Kernel.exec('vagrant up')
              end
            end
          end

          @app.call(env)
        end
      end

    end
  end
end
