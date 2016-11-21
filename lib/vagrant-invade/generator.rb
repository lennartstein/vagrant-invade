module VagrantPlugins
  module Invade
    module Generator

      autoload :Type, 'vagrant-invade/generator/type'

      class Generator

        attr_accessor :type

        def initialize(env)
          @env = env
          @type = Type::VAGRANT_PART

          @logger = Log4r::Logger.new('vagrant::invade::generator::vagrant')
        end
        
        def generate(machine: nil, part: nil, type: nil, data: nil)

          begin

            # Generates the templates with validated data
            case @type
              when Invade::Generator::Type::VAGRANTFILE
                generated_data = InvadeModule::Invade::Vagrantfile.new(data).build

              when Invade::Generator::Type::VAGRANT_PART
                generator_class_name = type.split('_').collect(&:capitalize).join
                generated_data = InvadeModule.const_get(generator_class_name).new(data).build

              when Invade::Generator::Type::MACHINE
                generated_data = InvadeModule::Invade::Machine.new(machine, data).build

              when Invade::Generator::Type::MACHINE_NESTED_PART
                type_formatted = type.split('_').collect(&:capitalize).join
                part_formatted = part.split('_').collect(&:capitalize).join
                generator_class_name = part_formatted + '::' + type_formatted
                generated_data = InvadeModule.const_get(generator_class_name).new(machine, data).build

              else
                generator_class_name = type.split('_').collect(&:capitalize).join
                generated_data = InvadeModule.const_get(generator_class_name).new(machine, data).build
            end

            return generated_data
          rescue StandardError => e
            @logger.error e
            fail e
          end
        end

      end

    end
  end
end
