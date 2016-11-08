module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Validate

        def initialize(app, env)
          @app = app
          @env = env

          @validator = Invade::Validator::Validator.new(env)
          @generator = Invade::Generator::Generator.new(env)

          @logger = Log4r::Logger.new('vagrant::invade::action::validate')
        end

        def call(env)
          config  = env[:invade]
          quiet   = @env[:invade_validate_quiet]

          ###############################################################
          # Validate the settings and set default variables if needed
          ###############################################################

          config[:vagrantfile] = Hash.new

          # Delete empty Hashes
          config.delete_blank

          config.each do |part_key, part_data|

            depth = part_data.depth
            if depth > 1

              part_data.each_with_index do |(machine, machine_part), index|

                machine_part.each do |machine_part_name, machine_part_data|
                  @env[:ui].info("\n[Invade][Machine: #{machine.upcase}]: Validating #{machine_part_name.upcase} part...") unless quiet

                  if machine_part_data.depth > 1
                    machine_part_data.each do |value_name, value_data|

                      # Output info message
                      info_message = "\t#{machine_part_name.split('_').collect(&:capitalize).join}: #{value_name}"
                      @env[:ui].info(info_message) unless @env[:invade_validate_quiet]

                      # Validation of machine parts configs (e.g: synced folder)
                      valid_data = validate(machine_part_name, value_name, value_data, machine_part_data.depth)

                      # Generate the template for Vagrantfile
                      @generator.type = Invade::Generator::Type::MACHINE_PART
                      @generator.generate(machine, machine_part_name, value_name, valid_data)
                    end
                  else
                    # Validation of general machine configs (e.g: vm)
                    valid_data = validate('Machine', machine_part_name, machine_part_data, machine_part_data.depth)

                    # Generate the template for Vagrantfile
                    @generator.type = Invade::Generator::Type::MACHINE
                    @generator.generate(machine, 'Machine', machine_part_name, valid_data)
                  end
                end
              end

              @env[:ui].success "\n[Invade]: Processed #{part_data.count} machine(s)."

            else
              # Info message
              @env[:ui].info("\n[Invade]: Validating #{part_key.upcase} part...") unless quiet

              # Validation of general non-machine-config (e.g: debug, invade)
              valid_data = validate(part_key, part_key, part_data, depth)

              # Generate the template for Vagrantfile
              @generator.type = Invade::Generator::Type::GENERAL
              @generator.generate(machine, 'General', part_key, valid_data)
            end

          end

          @app.call(env)
        end

        def validate(part_name, value_name, value_data, depth)
          @validator.depth = depth
          @validator.validate(part_name, value_name, value_data)
        end

      end
    end
  end
end
