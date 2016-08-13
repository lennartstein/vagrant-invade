module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Generate

        def initialize(app, env)
          @app = app
          @env = env
          @logger = Log4r::Logger.new('vagrant::invade::action::generate')
        end

        def call(env)

          # Define invade config
          config = @env[:invade]

          # Final vagrantfile hash
          vagrantfile = Hash.new

          # Machine hashes
          machine = Hash.new
          machine_part = Hash.new

          # Hostmanager plugin configuration
          unless config['hostmanager'] == nil
            vagrantfile['hostmanager'] = Generator::HostManager.new(config['hostmanager']).generate
          end

          # Iterate over each machine defined in config
          unless config['machines'] == nil
            config['machines'].each_with_index do |(name, part), index|

                # VM
              unless part['vm'] == nil
                machine_part['vm'] = Generator::MachinePart::VM.new(name, part['vm']).generate
              end

              # NETWORK
              unless part['network'] == nil
                machine_part['network'] = ''

                part['network'].each do |type, data|
                  machine_part['network'].concat(Generator::MachinePart::Network.new(name, type, data).generate)
                end
              end

              # SSH
              unless part['ssh'] == nil
                machine_part['ssh'] = (Generator::MachinePart::SSH.new(name, part['ssh']).generate)
              end

              # PROVIDER
              unless part['provider'] == nil
                machine_part['provider'] = ''

                part['provider'].each do |type, data|
                  parts = Generator::MachinePart::Provider.new(name, type, data).generate
                  machine_part['provider'].concat(parts)
                end
              end

              # SYNCED FOLDER
              unless part['synced_folder'] == nil
                machine_part['synced_folder'] = ''

                part['synced_folder'].each do |folder_name, data|
                  parts = Generator::MachinePart::SyncedFolder.new(name, data).generate
                  machine_part['synced_folder'].concat(parts)
                end
              end

              # PROVISION
              unless part['provision'] == nil
                machine_part['provision'] = ''

                part['provision'].each do |provision_name, data|
                  parts = Generator::MachinePart::Provision.new(name, provision_name, data).generate
                  machine_part['provision'].concat(parts)
                end
              end

              # PLUGIN
              unless part['plugin'] == nil
                machine_part['plugin'] = ''

                part['plugin'].each do |type, data|
                  parts = Generator::MachinePart::Plugin.new(name, @env[:ui], type, data).generate
                  machine_part['plugin'].concat(parts)
                end
              end

              # Generate machine from parts
              machine[name] = Generator::Machine.new(name, machine_part).generate

            end

            vagrantfile['machine'] = machine
          end

          # Finally generate Vagrantfile from machines and add it to Vagrant env
          @env[:invade]['vagrantfile'] = Generator::Vagrantfile.new(vagrantfile).generate

          # Finally done with generating. Delete machines from Vagrant env
          @env[:invade].delete("machines")

          @app.call(env)
        end

      end
    end
  end
end
