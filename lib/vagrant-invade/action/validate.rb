module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Validate

        def initialize(app, env)
          @app = app
          @env = env
          @logger = Log4r::Logger.new('vagrant::invade::action::validate')
        end

        def call(env)

          config = env[:invade]

          Validator.set_env(@env)
          Validator.set_invade(@env)

          ###############################################################
          # Validate the settings and set default variables if needed
          ###############################################################

          # INVADE
          config['invade'] = Validator::Invade.new(env, config['invade']).validate

          # Iterate over each machine configuration
          machines = config['machines']
          unless machines == nil
            machines.each_with_index do |(machine, sections), index|

              # VM
              unless sections['vm'] == nil
                sections['vm'] = Validator::VM.new(env, sections['vm']).validate
              end

              # NETWORK
              unless sections['network'] == nil
                sections['network'].each do |type, network|
                  case type
                  when 'private', 'private_network', 'privatenetwork', 'private-network'
                    network = Validator::Network::PrivateNetwork.new(env, network).validate
                  when 'forwarded', 'forwarded_port', 'forwarded-port', 'forwardedport', 'port'
                    network = Validator::Network::ForwardedPort.new(@machine_name, network).validate
                  when 'public', 'puplic_network', 'publicnetwork', 'public-network'
                    network = Validator::Network::PublicNetwork.new(@machine_name, network).validate
                  else
                    raise StandardError, "Network type unknown or not set. Please check the network configuration."
                  end
                end
              end

              # PROVIDER
              unless sections['provider'] == nil
                sections['provider'].each do |type, provider|
                  case type
                  when 'virtualbox'
                    provider = Validator::Provider::VirtualBox.new(env, provider).validate
                  when 'vmware'
                    provider = Validator::Provider::VMware.new(env, provider).validate
                  else
                    raise StandardError, "Provider unknown or not set. Please check configuration file."
                  end
                end
              end

              # SYNCED FOLDER
              unless sections['synced_folder'] == nil
                sections['synced_folder'].each do |type, sf|
                  case type
                  when 'nfs'
                    sf = Validator::SyncedFolder::NFS.new(env, sf).validate
                  when 'vb'
                    sf = Validator::SyncedFolder::VB.new(env, sf).validate
                  else
                    raise StandardError, "Synced Folder type unknown or not set. Please check configuration file."
                  end
                end
              end

              # PROVISION
              unless sections['provision'] == nil
                sections['provision'].each do |type, provision|
                  case type
                  when 'shell'
                    provision = Validator::Provision::Shell.new(env, provision).validate
                  when 'puppet'
                    provision = Validator::Provision::Puppet.new(env, provision).validate
                  else
                    raise StandardError, "Provision type unknown or not set. Please check configuration file."
                  end
                end
              end

              # SSH
              unless sections['ssh'] == nil
                sections['ssh'] = Validator::SSH.new(env, sections['ssh']).validate
              end

              unless sections['plugin'] == nil
                sections['plugin'].each do |type, plugin|
                  case type
                  when 'hostmanager'
                    plugin = Validator::Plugin::HostManager.new(env, plugin).validate
                  when 'winnfsd'
                    plugin = Validator::Plugin::WinNFSd.new(env, plugin).validate
                  else
                    raise StandardError, "Plugin type unknown or not set. Please check configuration file."
                  end
                end
              end

            end
          end

          if Validator::VALIDATION_ERRORS > 0
            @env[:ui].warn('[Invade] Configuration has validation warnings. Use debug mode to see details.')
          else
            @env[:ui].success('[Invade] Configuration validated successfully.')
          end

          @app.call(env)
        end

      end
    end
  end
end
