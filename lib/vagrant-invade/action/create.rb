module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Create

        def initialize(app, env)
          @app = app
          @env = env
          @ui = env[:ui]
          @logger = Log4r::Logger.new('vagrant::invade::action::create')

          ENV['VAGRANT_VAGRANTFILE'] ? @vagrantfile_name = ENV['VAGRANT_VAGRANTFILE'] : @vagrantfile_name = "Vagrantfile"
          @root_path = Dir.pwd
        end

        def call(env)

          data = @env[:invade]['vagrantfile']

          checksum_helper = Helper::Checksum.new @env
          vagrantfile_path = "#{@root_path}/#{@vagrantfile_name}"
          md5_current = checksum_helper.get_checksum_of_file(vagrantfile_path)
          md5_generated = checksum_helper.get_checksum_of_data(data)

          # Write new Vagrantfile if checksum is not equal
          if !checksum_helper.check
            write_vagrantfile(data, md5_current)

            @env[:ui].success "[Invade][BUILD] Current    : '#{md5_current}'"
            @env[:ui].success "[Invade][BUILD] Generated  : '#{md5_generated}'"
            @env[:ui].success "[Invade][BUILD] Saved new Vagrantfile to:"
            @env[:ui].success "[Invade][BUILD] #{vagrantfile_path}"
          else
            @ui.warn("[Invade][BUILD] Checksum: #{md5_current}")
            @ui.warn("[Invade][BUILD] No changes found in invade.yml - Vagrantfile will remain untouched.")
          end

          @app.call(env)
        end

        private

        def write_vagrantfile(data, checksum)

          vagrantfile = "#{@root_path}/#{@vagrantfile_name}"

          # Backup old Vagrantfile and safe it with checksum
          backup_file = vagrantfile + "-" + "#{checksum}"

          unless (File.exist?(backup_file) || !File.exist?(vagrantfile))
            File.rename(
              vagrantfile,
              backup_file
            )
          end

          # Write new Vagrantfile
          open(vagrantfile, "w+") do |f|
            f.puts data
          end

        end
      end

    end
  end
end
