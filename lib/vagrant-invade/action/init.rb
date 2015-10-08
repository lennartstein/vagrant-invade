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
            @env[:ui].error "[Invade] A 'invade.yml' file already exists. Use '--force' to replace file."
          end

          @app.call(env)
        end

        def invade_config_exists
          current_root_path = Dir.pwd
          invade_config_file =  "#{@dir}/invade.yml"
          if File.exist?(invade_config_file)
            return true
          end

          false
        end

        def invade_template_exists
          template_file_path = "#{@dir}/invade.yml.dist"
          if File.exist?(template_file_path)
            return true
          end

          false
        end

        def write_invade_config
          current_root_path = Dir.pwd
          config_file_path = "#{@dir}/invade.yml"
          puts config_file_path

          if invade_template_exists
            template_file_path = "#{@dir}/invade.yml.dist"
            FileUtils.cp(template_file_path, config_file_path)
            @env[:ui].success "[Invade] Copy of template 'invade.yml.dist' created successfully. Please make your changes."
          else
            plugin_root_path = File.expand_path('../../../../', __FILE__)
            default_config_file_path = "#{@plugin_root_path}/invade.yml.dist"
            FileUtils.cp(default_config_file_path, config_file_path)
            @env[:ui].success "[Invade] Copy of default 'invade.yml.dist' created successfully. Please make your changes."
          end
        end
      end

    end
  end
end
