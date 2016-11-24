module VagrantPlugins
  module Invade
    module Validator
      module Type

        class StringOrArrayValidator

          attr_accessor :value, :name, :default, :env

          def initialize(value, name, default, env)
            @value = value
            @name = name
            @default = default
            @env = env
          end

          def validate

            case @value
              when is_a?(String), is_a?(Array)
                @env[:ui].success("\t#{name} => '#{@value}'") unless @env[:invade_validate_quiet]

              when nil?
                @env[:ui].warn("\t#{name} not set. Use Vagrant default.") unless @env[:invade_validate_quiet]
                return default
              when ''
                @env[:ui].warn("\tError: Empty string is not valid. Set '#{name}' => '#{default}'.") unless @env[:invade_validate_quiet]
                return default
              else
                @env[:ui].error("\tError: '#{@value}' is not a string or array. Set to '#{name}' to default value '#{default}'.") unless @env[:invade_validate_quiet]
                return default
            end

            @value
          end
        end

      end
    end
  end
end
