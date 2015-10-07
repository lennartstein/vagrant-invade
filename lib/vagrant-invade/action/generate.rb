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

          @env[:ui].warn '[Invade] Generating Vagrantfile...'
          sleep 1

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

              # # NETWORK
              # unless section['network'] == nil
              #   puts section[]
              #   part['network'] = Generator::Section::Network.new(machine, section['network'].keys[0], section['network'].first).generate
              # end

              # NETWORK
              unless section['network'] == nil
                part['network'] = ''

                section['network'].each do |type, data|
                  part['network'].concat(Generator::Section::Network.new(machine, type, data).generate + "\n")
                end
              end

              # PROVIDER
              unless section['provider'] == nil
                part['provider'] = ''

                section['provider'].each do |type, data|
                  parts = Generator::Section::Provider.new(machine, type, data).generate
                  part['provider'].concat(parts + "\n")
                end
              end

              # SYNCED FOLDER
              unless section['synced_folder'] == nil
                part['synced_folder'] = ''

                section['synced_folder'].each do |type, data|
                  parts = Generator::Section::SyncedFolder.new(machine, type, data).generate
                  part['synced_folder'].concat(parts + "\n")
                end
              end

              unless section['provision'] == nil
                part['provision'] = ''

                section['provision'].each do |type, data|
                  parts = Generator::Section::Provision.new(machine, type, data).generate
                  part['provision'].concat(parts + "\n")
                end
              end

              # # SSH
              # unless section['ssh'] == nil
              #   part['ssh'] = Generator::Section::SSH.new(machine, section['ssh']).generate
              # end

              definition[machine] = Generator::Definition.new(machine, part).generate
            end

            # Finally generate Vagrantfile from generated definitions
            Generator::Vagrantfile.new(env, definition).generate
          end
        end

      end
    end
  end
end
