module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Validate

        def initialize(app, env)
          @app = app
          @env = env
          @logger = Log4r::Logger.new('vagrant::invade::action::validate')
          @validationErrors = 0
        end

        def call(env)

          @invade = env[:invade]

          ###############################################################
          # Validate the settings and set default variables if needed
          ###############################################################

          @invade['enabled'] = validate(@invade['enabled'], 'enabled', 'bool', true)

          # Iterate over each machine configuration
          machines = @invade['machines']
          machines.each_with_index do |(machine, section), index|

            invade_rand = rand(9999)

            # Box
            @env[:ui].info("[Invade] Validate machine #{machine.upcase} - Box") if @invade['debug']
            section['box']['name'] = validate(section['box']['name'], 'name', 'string', 'invade/default')
            section['box']['url']  = validate(section['box']['url'], 'url', 'string', nil)

            # Network
            @env[:ui].info("[Invade] Validate machine #{machine.upcase} - Network") if @invade['debug']
            section['network']['type']     = validate(section['network']['type'], 'type', 'string', 'private')
            section['network']['ip']       = validate(section['network']['ip'], 'ip', 'string', "192.168.133.#{7+index}")
            section['network']['hostname'] = validate(section['network']['hostname'], 'hostname', 'string', "invade#{index if index > 0}.vm")

            # Provider
            @env[:ui].info("[Invade] Validate machine #{machine.upcase} - Provider") if @invade['debug']
            section['provider']['name'] = validate(section['provider']['name'], 'name', 'string', "invade-#{invade_rand}-#{index}")
            section['provider']['type'] = validate(section['provider']['provider'], 'provider', 'string', 'virtualbox')
            section['provider']['cores'] = validate(section['provider']['cores'], 'cores', 'integer', 4)
            section['provider']['memory'] = validate(section['provider']['memory'], 'memory', 'integer', 512)
            section['provider']['hostresolver'] = validate(section['provider']['hostresolver'], 'hostresolver', 'bool', true)
            section['provider']['nicspeed'] = validate(section['provider']['nicspeed'], 'nicspeed', 'integer', 10485760)

            # Synced folder
            # Since more than one synced folder can be configured a loop is needed
            unless section['synced_folder'] == nil
              @env[:ui].info("[Invade] Validate machine #{machine.upcase} - Synced Folders") if @invade['debug']
              section['synced_folder'].each_with_index do |(sf, option), index|
                @env[:ui].info("\tSynced folder [#{index+1}]: #{sf}") if @invade['debug']
                option['enabled'] = validate(option['enabled'], 'enabled', 'bool', false)
                option['source'] = validate(option['source'], 'source', 'string', '.')
                option['path'] = validate(option['path'], 'path', 'string', '/www')
                option['type'] = validate(option['type'], 'type', 'string', '')
                option['owner'] = validate(option['owner'], 'owner', 'string', 'vagrant')
                option['group'] = validate(option['group'], 'group', 'string', 'root')
                option['dmode'] = validate(option['dmode'], 'dmode', 'integer', 755)
                option['fmode'] = validate(option['fmode'], 'fmode', 'integer', 664)
                option['nfs_options'] = validate(option['nfs_options'], 'nfs_options', 'array', ['nolock'])
              end
            end

            # PROVISION
            unless section['provision'] == nil
              @env[:ui].info("[Invade] Validate machine #{machine.upcase} - Provision") if @invade['debug']
              section['provision'].each_with_index do |(provision, option), index|
                @env[:ui].info("\tProvisioning [#{index+1}]: #{provision}") if @invade['debug']
                option['enabled'] = validate(option['enabled'], 'enabled', 'bool', false)
                option['type'] = validate(option['type'], 'type', 'string', nil)
                option['file'] = validate(option['file'], 'file', 'string', nil)
                option['inline'] = validate(option['inline'], 'inline', 'string', nil)
                option['options'] = validate(option['options'], 'options', 'array', [])
              end
            end

            # SSH
            @env[:ui].info("[Invade] Validate machine #{machine.upcase} - SSH") if @invade['debug']
            section['ssh']['enabled'] = validate(section['ssh']['enabled'], 'enabled', 'bool', true)
            section['ssh']['folder'] = validate(section['ssh']['folder'], 'folder', 'string', '~/.shh/')

            # PLUGINS
            @env[:ui].info("[Invade] Validate machine #{machine.upcase} - Plugins") if @invade['debug']

            # PLUGIN: Hostmanager
            @env[:ui].info("\tHostmanager:") if @invade['debug']
            section['plugins']['hostmanager']['enabled'] = validate(
              section['plugins']['hostmanager']['enabled'], 'enabled', 'bool', true
            )
            section['plugins']['hostmanager']['manage_host'] = validate(
              section['plugins']['hostmanager']['manage_host'], 'manage_host', 'bool', true
            )
            section['plugins']['hostmanager']['ignore_private_ip'] = validate(
              section['plugins']['hostmanager']['ignore_private_ip'], 'ignore_private_ip', 'bool', false
            )
            section['plugins']['hostmanager']['include_offline'] = validate(
              section['plugins']['hostmanager']['include_offline'], 'include_offline', 'bool', true
            )
            section['plugins']['hostmanager']['aliases'] = validate(
              section['plugins']['hostmanager']['aliases'], 'aliases', 'array', []
            )

            # PLUGIN: Winnfsd
            @env[:ui].info("\tWinnfsd:") if @invade['debug']
            section['plugins']['winnfsd']['enabled'] = validate(
              section['plugins']['winnfsd']['enabled'], 'enabled', 'bool', true
            )
            section['plugins']['winnfsd']['logging'] = validate(
              section['plugins']['winnfsd']['logging'], 'logging', 'bool', false
            )
          end

          if @validationErrors > 0
            @env[:ui].warn('[Invade] Validation of configuration has warnings. Use debug mode to see details.')
          else
            @env[:ui].success('[Invade] Validation of configuration succeeded.')
          end

          @app.call(env)
        end

        private

        def validate(value, name, type, default)

          case type
          when 'bool'
            validate_boolean(value, name, default)
          when 'string'
            validate_string(value, name, default)
          when 'integer'
            validate_integer(value, name, default)
          when 'array'
            validate_array(value, name, default)
          else
            @env[:ui].warn(
              "\t'#{value}' not a type. Defined variable types are boolean, string, integer and array. Option is set to default '#{default}'."
            )
            return default
          end
        end

        # Validates to BOOLEAN and returns the value at success or a default if not
        def validate_boolean(value, name, default)

          if [true, false].include? value
            @env[:ui].success("\t#{name} => #{value}") if @invade['debug']
          elsif value === nil
            @env[:ui].info("\tOption is not set. Set '#{name}' => #{default.to_s.upcase}.") if @invade['debug']
            return default
          else
            @env[:ui].warn("\tWarning: #{name} => #{value} is not a boolean. Set '#{name}' to default value #{default.to_s.upcase}.")
            @validationErrors = @validationErrors + 1
            return default
          end

          value
        end

        # Validates to STRING and returns the value at success or a default if not
        def validate_string(value, name, default)

          if value.is_a? String
            @env[:ui].success("\t#{name} => '#{value}'") if @invade['debug']
          elsif value === nil
            @env[:ui].info("\tOption is not set. Set '#{name}' => '#{default}'.") if @invade['debug']
            return default
          elsif value === ''
            @env[:ui].warn("\tEmpty string is not valid. Set '#{name}' => '#{default}'.") if @invade['debug']
            return default
          else
            @env[:ui].warn("\tWarning: '#{value}' is not a string. Set to '#{name}' to default value '#{default}'.")
            @validationErrors = @validationErrors + 1
            return default
          end

          value
        end

        # Validates to INT and returns the value at success or a default if not
        def validate_integer(value, name, default)

          if value.is_a? Integer or is_number(value)
            @env[:ui].success("\t#{name} => #{value}") if @invade['debug']
          elsif value === nil
            @env[:ui].info("\tOption is not set. Set '#{name}' => '#{default}'.") if @invade['debug']
            return default
          else
            @env[:ui].warn("\tWarning: '#{value}' is not an integer. Set '#{name}' to default value #{default}.")
            @validationErrors = @validationErrors + 1
            return default
          end

          value
        end

        # Validates to ARRAY and returns the value at success or a default if not
        def validate_array(value, name, default)

          if value.is_a? Array
            @env[:ui].success("\t#{name} => #{value}") if @invade['debug']
          elsif value === nil
            @env[:ui].info("\tOption is not set. Set '#{name}' => '#{default}'.")  if @invade['debug']
            return default
          else
            @env[:ui].warn("\tWarning: '#{value}' is not an array. Set '#{name}' to default value #{default}.")
            @validationErrors = @validationErrors + 1
            return default
          end

          value
        end

        def is_number(value)
          value.to_f.to_s == value.to_s || value.to_i.to_s == value.to_s
        end

      end
    end
  end
end
