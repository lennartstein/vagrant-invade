module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Check

        def initialize(app, env)
          @app = app
          @env = env
          @ui = env[:ui]
          @logger = Log4r::Logger.new('vagrant::invade::action::create')

          ENV['VAGRANT_VAGRANTFILE'] ? @vagrantfile_name = ENV['VAGRANT_VAGRANTFILE'] : @vagrantfile_name = 'Vagrantfile'
          @root_path = Dir.pwd
        end

        def call(env)

          data = @env[:invade]['vagrantfile']

          checksum_helper = Helper::Checksum.new data
          vagrantfile_path = "#{@root_path}/#{@vagrantfile_name}"
          md5_current = checksum_helper.get_checksum_of_file(vagrantfile_path)
          md5_generated = checksum_helper.get_checksum_of_data(data)

          # Write new Vagrantfile if checksum is not equal
          if !checksum_helper.check
            @ui.success "[Invade][CHECK] Current    : '#{md5_current}'"
            @ui.success "[Invade][CHECK] Generated  : '#{md5_generated}'"
            @ui.success "[Invade][CHECK] same"
          else
            @ui.warn "[Invade][CHECK] Current    : '#{md5_current}'"
            @ui.warn "[Invade][CHECK] Generated  : '#{md5_generated}'"
            @ui.warn '[Invade][CHECK] not same'
          end

          @app.call(env)
        end
      end

    end
  end
end
