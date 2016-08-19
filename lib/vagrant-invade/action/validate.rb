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
          config  = env[:invade]
          quiet   = @env[:invade_validate_quiet]

          @validator = Validator::VagrantValidator.new(env)

          ###############################################################
          # Validate the settings and set default variables if needed
          ###############################################################

          config.each do |part_key, part_data|

            unless part_data.nil?

              depth = part_data.depth
              if depth > 1

                # Iterate over parts of each machine
                part_data.each_with_index do |(machine, machine_part), index|

                  machine_part.each do |machine_part_name, machine_part_data|
                    @env[:ui].info("\n[Invade][Machine: #{machine.upcase}]: Validating #{machine_part_name.upcase} part...") unless quiet

                    if machine_part_data.depth > 1
                      machine_part_data.each do |value_name, value_data|
                        value_data = validate(machine_part_name, value_name, value_data, machine_part_data.depth)
                      end
                    else
                      machine_part_data = validate('General', machine_part_name, machine_part_data, machine_part_data.depth)
                    end
                  end

                end

                @env[:ui].success "\n[Invade]: Processed #{part_data.count} machine(s)."

              else
                @env[:ui].info("\n[Invade]: Validating #{part_key.upcase} part...") unless quiet

                part_data = validate(part_key, part_key, part_data, depth)
              end

            end
          end

          @app.call(env)
        end

        def validate(part_name, value_name, value_data, depth)

          if depth > 1
            info_message = "\t#{part_name.split('_').collect(&:capitalize).join}: #{value_name}"
            @env[:ui].info(info_message) unless @env[:invade_validate_quiet]
          end

          # Set depth
          @validator.depth = depth

          # Validate data
          return @validator.validate(
            part_name, value_name, value_data
          )
        end

      end
    end
  end
end
