module VagrantPlugins
  module Invade
    module Validator
      module Type

        class StringValidator

          attr_accessor :value, :name, :default, :env

          def initialize(value, name, default, env)
            @value = value
            @name = name
            @default = default
            @env = env
          end

          def validate

            if @value.is_a?(String)
              @env[:ui].success("\t#{name} => '#{@value}'") unless @env[:invade_validate_quiet]
            elsif @value === nil
              @env[:ui].warn("\t#{name} not set. Use Vagrant default.") unless @env[:invade_validate_quiet]

              return default
            elsif @value === ''
              @env[:ui].warn("\tError: Empty string is not valid. Set '#{name}' => '#{default}'.") unless @env[:invade_validate_quiet]

              return default
            else
              @env[:ui].error("\tError: '#{@value}' is not a string. Set to '#{name}' to default value '#{default}'.") unless @env[:invade_validate_quiet]

              return default
            end

            @value
          end
        end

      end
    end
  end
end
