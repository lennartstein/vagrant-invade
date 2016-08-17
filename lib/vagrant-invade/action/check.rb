module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Check

        def initialize(app, env)
          @app = app
          @env = env
          @logger = Log4r::Logger.new('vagrant::invade::action::init')
          @dir = Dir.pwd

          ENV['VAGRANT_VAGRANTFILE'] ? @vagrantfile_name = ENV['VAGRANT_VAGRANTFILE'] : @vagrantfile_name = "Vagrantfile"
          @root_path = Dir.pwd
        end

        def call(env)

          data = @env[:invade]['vagrantfile']

          checksum_helper = Helper::Checksum.new @env
          vagrantfile_path = "#{@root_path}/#{@vagrantfile_name}"
          md5_current = checksum_helper.get_checksum_of_file(vagrantfile_path)
          md5_generated = checksum_helper.get_checksum_of_data(data)

          if checksum_helper.check
            @env[:ui].success "[Invade][CHECK] #{md5_current}"
            @env[:ui].success "[Invade][CHECK] Checksum is valid!"
          else
            @env[:ui].warn "[Invade][CHECK] Changes found. Checksum is not equal!"
            @env[:ui].warn "[Invade][CHECK] #{@vagrantfile_name} \tMD5:#{md5_current}"
            @env[:ui].warn "[Invade][CHECK] invade.yml\tMD5:#{md5_generated}"
          end

          @app.call(env)
        end

      end

    end
  end
end
