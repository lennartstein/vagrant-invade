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

          # Iterate over each machine configuration
          machines = config['machines']

          unless machines == nil

            part = Hash.new
            definition = Hash.new

            machines.each_with_index do |(machine, section), index|

              # VM
              unless section['vm'] == nil
                part['vm'] = Generator::Section::VM.new(machine, section['vm']).generate
              end

              # NETWORK
              unless section['network'] == nil
                part['network'] = ''

                section['network'].each do |type, data|
                  part['network'].concat(Generator::Section::Network.new(machine, type, data).generate)
                end
              end

              # PROVIDER
              unless section['provider'] == nil
                part['provider'] = ''

                section['provider'].each do |type, data|
                  parts = Generator::Section::Provider.new(machine, type, data).generate
                  part['provider'].concat(parts)
                end
              end

              # SYNCED FOLDER
              unless section['synced_folder'] == nil
                part['synced_folder'] = ''

                section['synced_folder'].each do |type, data|
                  parts = Generator::Section::SyncedFolder.new(machine, type, data).generate
                  part['synced_folder'].concat(parts)
                end
              end

              # SYNCED FOLDER
              unless section['provision'] == nil
                part['provision'] = ''

                section['provision'].each do |type, data|
                  parts = Generator::Section::Provision.new(machine, type, data).generate
                  part['provision'].concat(parts)
                end
              end

              unless section['plugin'] == nil
                part['plugin'] = ''

                section['plugin'].each do |type, data|
                  parts = Generator::Section::Plugin.new(machine, @env[:ui], type, data).generate
                  part['plugin'].concat(parts)
                end
              end

              # # SSH
              # unless section['ssh'] == nil
              #   part['ssh'] = Generator::Section::SSH.new(machine, section['ssh']).generate
              # end

              # Add as definition
              definition[machine] = Generator::Definition.new(machine, part).generate
            end

            # Finally generate Vagrantfile from generated definitions and add it to Vagrant environment
            @env[:invade]['vagrantfile'] = Generator::Vagrantfile.new(env, definition).generate

            # Finally done with generating. Delete machines from Vagrant environment
            @env[:invade].delete("machines")

            @app.call(env)
          end
        end

      end
    end
  end
end
