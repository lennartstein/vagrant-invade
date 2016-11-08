module VagrantPlugins
  module Invade
    module Generator

      autoload :Type, 'vagrant-invade/generator/type'

      class Generator

        attr_accessor :type

        def initialize(env)
          @env = env
          @type = Type::GENERAL

          @logger = Log4r::Logger.new('vagrant::invade::generator::vagrant')
        end

        def generate(machine, part, type, data)

          begin

            type_formatted = type.split('_').collect(&:capitalize).join
            part_formatted = part.split('_').collect(&:capitalize).join

            # Return class dynamically with class name string
            if @type == VagrantPlugins::Invade::Generator::Type::GENERAL
              generator_class_name = type_formatted
            elsif @type == VagrantPlugins::Invade::Generator::Type::MACHINE
              generator_class_name = type_formatted
            else
              generator_class_name = part_formatted + '::' + type_formatted
            end

            test = InvadeModule.const_get(generator_class_name).new(machine, data)
            puts test.build

          rescue StandardError => e
            @logger.error e
            fail e
          end
        end
      end

    end
  end
end
