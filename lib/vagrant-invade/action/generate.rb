module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin
      include VagrantPlugins::Invade::Generator

      class Generate

        def initialize(app, env)
          @app = app
          @env = env
          @logger = Log4r::Logger.new('vagrant::invade::action::generate')
          @machine_name = "default"
        end

        def call(env)

          @env[:ui].warn '[Invade] Generating Vagrantfile...'
          sleep 1

          # Get current machine name
          @machine_name = env[:invade]['machines'].keys.first.to_s

          sections = Hash.new

          # Box section generation
          sections['box'] = generate_box(
            env[:invade]['machines']['lps']['box']
          )

          # Network section generation
          sections['network'] = generate_network(
            env[:invade]['machines']['lps']['network']
          )

          sections['provider'] = generate_provider(
            env[:invade]['machines']['lps']['provider']
          )

          # # Virutal Machine section generation
          # sections['vm'] = generate_virtual_machine(
          #   env[:invade]['machines']['lps']['vm']
          # )
          #
          # # Synced Folder section generation
          # sections['synced_folder'] = generate_synced_folder(
          #   env[:invade]['machines']['lps']['sf']
          # )
          #
          # # Provision section generation
          # sections['provision'] = generate_provision(
          #   env[:invade]['machines']['lps']['provision']
          # )

          # Finally generate Vagrantfile
          vagrantfile = generate_vagrantfile(env, sections)
          vagrantfile

          @app.call(env)
        end

        private

        def generate_box(options)
          box = Generator::Box.new(@machine_name, options)
          box.build

          box.result
        end

        def generate_network(options)
          network = Generator::Network.new(@machine_name, options)
          network.build

          network.result
        end

        def generate_provider(options)
          case options['type']
          when 'virtualbox'
            provider = Generator::Provider::VirtualBox.new(@machine_name, options)
          when 'vmware'
            provider = Generator::Provider::VMware.new(@machine_name, options)
          else
            raise StandardError, "Provider unknown or not set. Please check the provider configuration."
          end

          provider.build

          provider.result
        end

        def generate_vagrantfile(env, sections)
          require 'digest'
          require 'vagrant-invade/generator/vagrantfile'

          vagrantfile = Generator::Vagrantfile.new(@machine_name, sections)
          vagrantfile.build

          # Get project root and default vagrantfile filename
          ENV['VAGRANT_VAGRANTFILE'] ? vagrantfile_name = ENV['VAGRANT_VAGRANTFILE'] : vagrantfile_name = "Vagrantfile"

          currentVagrantfile = "#{env[:root_path]}/#{vagrantfile_name}"

          # Compare md5 strings to replace Vagrantfile only if content changed
          md5_new = Digest::MD5.hexdigest(vagrantfile.result)
          md5_current = Digest::MD5.file(currentVagrantfile).hexdigest

          unless md5_new.equal? md5_current

            open("myfile.out", 'w+') do |f|
              f.puts vagrantfile.result
            end

            # open("#{currentVagrantfile}", 'w+') do |f|
            #   f.puts vagrantfile.result
            # end

            @env[:ui].warn '[Invade] Restarting Vagrant with new Vagrantfile...'
            sleep 2

            if !Vagrant.in_installer? && !Vagrant.very_quiet?
              Kernel.exec('bundle exec vagrant up')
            else
              Kernel.exec('vagrant up')
            end
          end
        end

      end
    end
  end
end
