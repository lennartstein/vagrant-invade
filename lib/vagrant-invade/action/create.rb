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
          root_path = Dir.pwd
          ENV['VAGRANT_VAGRANTFILE'] ? vagrantfile_name = ENV['VAGRANT_VAGRANTFILE'] : vagrantfile_name = "Vagrantfile"

          # Get generated Vagrantfile from environment
          if @env[:invade]['vagrantfile']
            generated_vagrantfile = @env[:invade]['vagrantfile']
          else
            raise "[Invade]: No generated data found. Can't build Vagrantfile."
          end

          # Write new Vagrantfile if checksum is not equal and auto mode is enabled
          unless check_md5_checksum(@env[:ui], root_path, vagrantfile_name, generated_vagrantfile)
              @env[:invade_build_force] ?
              write_vagrantfile(@env[:ui], root_path, generated_vagrantfile, vagrantfile_name, true) :
              write_vagrantfile(@env[:ui], root_path, generated_vagrantfile, vagrantfile_name, false)
          end

          @app.call(env)
        end

        private

        # Compare md5 strings to replace Vagrantfile
        def check_md5_checksum(ui, root_path, vagrantfile_name, generated_vagrantfile)

          require 'digest'

          md5_new = Digest::MD5.hexdigest(generated_vagrantfile)

          if File.exists?("#{root_path}/#{vagrantfile_name}")
            md5_current = Digest::MD5.file("#{root_path}/#{vagrantfile_name}").hexdigest
          else
            md5_current = 0
          end

          (md5_new.eql? md5_current) ? md5_check = true : md5_check = false

          unless md5_check
            ui.warn "[Invade] Checksum not equal!"
            ui.warn "[Invade] Current    : '#{md5_current}'"
            ui.warn "[Invade] Generated  : '#{md5_new}'"
            return false
          end

          ui.success "[Invade] Vagrantfile is still valid. No need to rebuild. Or use --force."

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
          ui.warn("[Invade] Saved new Vagrantfile at '#{root_path}/#{vagrantfile_name}.new'")
        end
      end

    end
  end
end
