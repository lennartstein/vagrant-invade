module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Create

        def initialize(app, env)
          @app = app
          @env = env
          @logger = Log4r::Logger.new('vagrant::invade::action::create')
        end

        def call(env)

          # Get project root and default vagrantfile filename
          ENV['VAGRANT_VAGRANTFILE'] ? vagrantfile_name = ENV['VAGRANT_VAGRANTFILE'] : vagrantfile_name = "Vagrantfile"
          root_path = @env[:root_path]

          # Get generated Vagrantfile from environment
          generated_vagrantfile = @env[:invade]['vagrantfile']

          # Get auto_mode from env
          auto_mode = @env[:invade]['invade']['auto']

          # Write new Vagrantfile if checksum is not equal and auto mode is enabled
          unless check_md5_checksum(@env[:ui], root_path, vagrantfile_name, generated_vagrantfile)

              # Write Vagrantfile
              auto_mode ?
              write_vagrantfile(@env[:ui], root_path, generated_vagrantfile, vagrantfile_name, true) :
              write_vagrantfile(@env[:ui], root_path, generated_vagrantfile, vagrantfile_name, false)

              # Reload
              reload(@env[:ui]) if auto_mode
          end
        end

        private

        # Compare md5 strings to replace Vagrantfile
        def check_md5_checksum(ui, root_path, vagrantfile_name, generated_vagrantfile)

          require 'digest'

          md5_new = Digest::MD5.hexdigest(generated_vagrantfile)
          md5_current = Digest::MD5.file("#{root_path}/#{vagrantfile_name}").hexdigest

          ui.success "[Invade] Checking Vagrantfile (#{md5_current})..."
          (md5_new.eql? md5_current) ? md5_check = true : md5_check = false

          unless md5_check
            ui.warn "[Invade] Vagrantfile (#{md5_current}) not equal with configuration (#{md5_new})."
            return false
          end

          ui.success "[Invade] Vagrantfile is valid."

          true
        end

        def reload(ui)

          # Get corrent command whether in development mode or using Vagrant for real
          unless Vagrant.in_installer? && Vagrant.very_quiet?
            command = 'bundle exec vagrant reload'
          else
            command = 'vagrant reload'
          end

          ui.warn '[Invade] Auto reload Vagrant with new Vagrantfile...'
          sleep 2

          Kernel.exec(command)
        end

        def write_vagrantfile(ui, root_path, vagrantfile, vagrantfile_name, overwrite)

          overwrite ?
          vagrantfile_path = "#{root_path}/#{vagrantfile_name}" :
          vagrantfile_path = "#{root_path}/#{vagrantfile_name}.new"

          # Write new Vagrantfile
          open(vagrantfile_path, "w+") do |f|
            f.puts vagrantfile
          end

          overwrite ?
          ui.warn('[Invade] Replaced old Vagrantfile.') :
          ui.warn("[Invade] Saved new Vagrantfile as #{root_path}/#{vagrantfile_name}.new")
        end
      end

    end
  end
end
