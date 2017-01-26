module VagrantPlugins
  module Invade
    module Action

      include Vagrant::Action::Builtin

      class Process

        def initialize(app, env)
          @app = app
          @env = env

          @validator = VagrantPlugins::Invade::Validator::Validator.new(env)
          @generator = VagrantPlugins::Invade::Generator::Generator.new(env)

          @invade_machine = Hash.new
          @invade_machine_part = Hash.new
          @invade_vagrantfile = Hash.new

          @generate = @env[:invade_generate]
          @quiet = @env[:invade_validate_quiet]

          @logger = Log4r::Logger.new('vagrant::invade::action::validate')
        end

        def call(env)

          config = env[:invade]

          # If config data is not a hash, something went totally wrong or it's not correct YAML
          # This should never happen - but better to stop the progress here.
          if !config.is_a?(Hash)
            raise "Something went wrong parsing your configuration file. Is your YAML in a correct format?"
          end

          config.each do |config_key, config_data|
            if config_key == 'machine'
              process_machines(config_data)
            else
              process_vagrant_part(config_key, config_data)
            end
          end

          @env[:invade]['vagrantfile'] = generate(
              data: @invade_vagrantfile,
              generator_type: Invade::Generator::Type::VAGRANTFILE
          ) if @generate

          @env[:invade].delete('machine')

          @app.call(env)
        end

        private

        def process_machines(machine)

          # Iterate over machine configurations
          machine.each_with_index do |(machine, machine_data), _|
            process_machine(machine, machine_data)
          end

          @invade_vagrantfile['machine'] = @invade_machine
          @env[:ui].success "\n[Invade]: Processed #{machine.count} machine(s)."

        end

        def process_machine(machine_name, machine_data)

          # Iterate over each machine part configuration
          machine_data.each do |machine_part_name, machine_part_data|
            @env[:ui].info("\n[Invade][Machine: #{machine_name.upcase}]: Validating #{machine_part_name.upcase} part...") unless @quiet

            if machine_part_data.depth > 1
              process_machine_nested_part(machine_name, machine_part_name, machine_part_data)
            else
              process_machine_part(machine_name, machine_part_name, machine_part_data)
            end

            @invade_machine[machine_name] = generate(
                machine_name: machine_name,
                data: @invade_machine_part,
                generator_type: Invade::Generator::Type::MACHINE
            )
          end
        end

        def process_machine_part(machine, machine_part_name, machine_part_data)

          validated_data = validate('Machine', machine_part_name, machine_part_data, machine_part_data.depth)
          @invade_machine_part[machine_part_name] = generate(
              machine_name: machine,
              part_type: machine_part_name,
              data: validated_data,
              generator_type: Invade::Generator::Type::MACHINE_PART
          ) if @generate
        end

        def process_machine_nested_part(machine, machine_part_name, machine_part_data)

          @invade_machine_part[machine_part_name] = ''
          machine_part_data.each do |value_name, value_data|

            # Output info message
            info_message = "\t#{machine_part_name.split('_').collect(&:capitalize).join}: #{value_name}"
            @env[:ui].info(info_message) unless @env[:invade_validate_quiet]

            # Exception handling for synced_folder and provision types
            if machine_part_name == 'synced_folder' or machine_part_name == 'provision'
              value_name = value_data['type']
              value_data.delete('type')
            end

            validated_data = validate(machine_part_name, value_name, value_data, machine_part_data.depth)
            @invade_machine_part[machine_part_name].concat(
                generate(
                    machine_name: machine,
                    part: machine_part_name,
                    part_type: value_name,
                    data: validated_data,
                    generator_type: Invade::Generator::Type::MACHINE_NESTED_PART
              )
            ) if @generate
          end
          
        end

        def process_vagrant_part(config_key, config_data)
          @env[:ui].info("\n[Invade]: Validating #{config_key.upcase} part...") unless @quiet

          validated_data = validate(config_key, config_key, config_data, config_data.depth)
          @invade_vagrantfile[config_key] = generate(
            part_type: config_key,
            data: validated_data,
            generator_type: Invade::Generator::Type::VAGRANT_PART
          ) if @generate
        end

        def validate(part_name, value_name, value_data, depth)
          @validator.depth = depth
          @validator.validate(part_name, value_name, value_data)
        end

        def generate(machine_name: nil, part: nil, part_type: nil, data: nil, generator_type: nil)
          @generator.type = generator_type
          @generator.generate(
              machine: machine_name,
              part: part,
              type: part_type,
              data: data
          )
        end

      end
    end
  end
end
