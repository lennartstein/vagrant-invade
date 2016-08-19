module VagrantPlugins
  module Invade
    module Validator
      module Type

        class IntegerValidator

          attr_accessor :value, :name, :default, :env

          def initialize(value, name, default, env)
            @value = value
            @name = name
            @default = default
            @env = env
          end

          public

          def validate

            if @value.is_a?(Integer) || is_number(@value)
              @env[:ui].success("\t#{@name} => #{@value}") unless @env[:invade_validate_quiet]
            elsif @value === nil
              @env[:ui].warn("\t#{@name} not set. Use Vagrant default.") unless @env[:invade_validate_quiet]

              return default
            else
              @env[:ui].error("\tError: '#{@value}' is not an integer. Set '#{@name}' to default value #{default}.") unless @env[:invade_validate_quiet]

              return default
            end

            @value
          end

          private

          def is_number(value)
            value.to_f.to_s == value.to_s || value.to_i.to_s == value.to_s
          end
        end

      end
    end
  end
end
