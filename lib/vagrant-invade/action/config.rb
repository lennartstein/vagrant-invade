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
          template_file_path = "#{config_file_path}.dist"
          default_config_file_path = "#{File.expand_path('../../../../', __FILE__)}/invade.yml.dist"

          # Returns with invade in environment if Invade Configuration file already exists
          if File.exist?(config_file_path)
            @logger.debug 'Config file found. Proceed.'
            @env[:ui].info "[Invade] Using Plugin vagrant-invade-#{VERSION} to setup Vagrant!"

            # Add invade configuration as global environment variable since we know configuration file exists
            env[:invade] = Invade.get_invade_config
            unless env[:invade]
              raise "Something went wront. Configuration file could not be loaded."
            end
          else
            @env[:ui].info "[Invade] 'invade.yml' not exists. You forgot a 'vagrant invade init'?"
            exit

            # # Try to copy template path from vagrant repository of project.
            # begin
            #   FileUtils.cp(template_file_path, config_file_path)
            #   @logger.debug 'Config file could not be found. Copied template file.'
            #   @env[:ui].debug '[Invade] Configuration file could not be found.'
            #   @env[:ui].warn '[Invade] Copying template configuration...'
            #   @env[:ui].warn "\tFrom: \"#{template_file_path}\""
            #   @env[:ui].warn "\tTo: \"#{config_file_path}\""
            #   sleep 2
            #   @env[:ui].warn '[Invade] Restarting vagrant...'
            #   sleep 3
            #   if !Vagrant.in_installer? && !Vagrant.very_quiet?
            #     Kernel.exec('bundle exec vagrant up') if @env[:invade_command]
            #   else
            #     Kernel.exec('vagrant up') if @env[:invade_command]
            #   end
            # rescue
            #   # If not found default invade configuration file will be copied.
            #   FileUtils.cp(default_config_file_path, config_file_path)
            #   @logger.info 'Template file could not be found. Copied default invade configuration file.'
            #   @env[:ui].warn '[Invade] Template file could not be found.'
            #   @env[:ui].warn '[Invade] Copying default configuration...'
            #   @env[:ui].warn "\tFrom: \"#{template_file_path}\""
            #   @env[:ui].warn "\tTo: \"#{config_file_path}\""
            #   sleep 2
            #   @env[:ui].warn '[Invade] Restarting vagrant...'
            #   sleep 3
            #   if !Vagrant.in_installer? && !Vagrant.very_quiet?
            #     Kernel.exec('bundle exec vagrant up') if @env[:invade_command]
            #   else
            #     Kernel.exec('vagrant up') if @env[:invade_command]
            #   end
            # end
          end

          @app.call(env)
        end
      end

    end
  end
end
