module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Init

        def initialize(app, env)
          @app = app
          @env = env
          @logger = Log4r::Logger.new('vagrant::invade::action::init')
          @dir = Dir.pwd
        end

        def call(env)

          if !invade_config_exists || @env[:invade_command_init_force]
            write_invade_config
          else
            @env[:ui].error "[Invade] 'invade.yml' file already exists. Use '--force' to replace file."
          end

          @app.call(env)
        end

        def invade_config_exists
          File.exist?("#{@dir}/invade.yml")
        end

        def invade_template_exists
          File.exist?("#{@dir}/invade.yml.dist")
        end

        def invade_user_customized_config_exists
          File.exist?(File.expand_path('~/.invade/invade.yml.dist'))
        end

        # Writes configuration file 'invade.yml'
        #   if template file in project folder does exist it copies it#
        #   if template file in project folder doesn't exist and a '~/.invade/invade.yml.dist' file exists it copies it
        #   if template file in project folder doesn't exist it uses plugins default file
        def write_invade_config
          invade_config_file = "#{@dir}/invade.yml"

          if invade_template_exists
            template_file_path = "#{@dir}/invade.yml.dist"
            FileUtils.cp(template_file_path, invade_config_file)
            @env[:ui].success "[Invade] Project template file '#{template_file_path}' was found!"
          elsif invade_user_customized_config_exists && !invade_template_exists
            FileUtils.cp(File.expand_path('~/.invade/invade.yml.dist'), invade_config_file)
            @env[:ui].success "[Invade] User customized template file '~/.invade/invade.yml.dist' was found!"
          else
            plugin_root_path = File.expand_path('../../../..', __FILE__)
            default_invade_config_file = plugin_root_path + '/invade-default.yml'
            FileUtils.cp(default_invade_config_file, invade_config_file)
            @env[:ui].warn '[Invade] Project template file or customized user configuration file NOT found!'
          end

          @env[:ui].success '[Invade] \'invade.yml\' created successfully. Please make your changes.'
        end
      end

    end
  end
end
