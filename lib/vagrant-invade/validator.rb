module VagrantPlugins
  module Invade
    module Validator

      autoload :Invade, 'vagrant-invade/validator/invade'
      autoload :VM, 'vagrant-invade/validator/vm'
      autoload :Network, 'vagrant-invade/validator/network'
      autoload :Provider, 'vagrant-invade/validator/provider'
      autoload :Provision, 'vagrant-invade/validator/provision'
      autoload :SyncedFolder, 'vagrant-invade/validator/synced_folder'
      autoload :SSH, 'vagrant-invade/validator/ssh'
      autoload :Plugin, 'vagrant-invade/validator/plugin'

      attr_accessor :env, :invade, :validation_errors

      @validation_errors = 0
      @env = nil

      def self.set_env(env)
        @env = env
      end

      # Validates to BOOLEAN and returns the value at success or a default if not
      def self.validate_boolean(value, name, default)

        if [true, false].include?(value)
          @env[:ui].success("\t#{name} => #{value}") unless @env[:invade_validate_quiet]
        elsif value === nil
          @env[:ui].warn("\t#{name} not set. Use Vagrant default.") unless @env[:invade_validate_quiet]
          return default
        else
          @env[:ui].error("\tError: #{name} => #{value} is not a boolean. Set '#{name}' to default value #{default.to_s.upcase}.") unless @env[:invade_validate_quiet]
          @validation_errors = @validation_errors + 1
          return default
        end

        value
      end

      # Validates to STRING and returns the value at success or a default if not
      def self.validate_string(value, name, default)

        if value.is_a?(String)
          @env[:ui].success("\t#{name} => '#{value}'") unless @env[:invade_validate_quiet]
        elsif value === nil
          @env[:ui].warn("\t#{name} not set. Use Vagrant default.") unless @env[:invade_validate_quiet]
          return default
        elsif value === ''
          @env[:ui].warn("\tError: Empty string is not valid. Set '#{name}' => '#{default}'.") unless @env[:invade_validate_quiet]
          @validation_errors = @validation_errors + 1
          return default
        else
          @env[:ui].error("\tError: '#{value}' is not a string. Set to '#{name}' to default value '#{default}'.") unless @env[:invade_validate_quiet]
          @validation_errors = @validation_errors + 1
          return default
        end

        value
      end

      def self.validate_string_or_array(value, name, default)

        if value.is_a?(String) || value.is_a?(Array)
          @env[:ui].success("\t#{name} => '#{value}'") unless @env[:invade_validate_quiet]
        elsif value === nil
          @env[:ui].warn("\t#{name} not set. Use Vagrant default.") unless @env[:invade_validate_quiet]
          return default
        elsif value === ''
          @env[:ui].warn("\tError: Empty string is not valid. Set '#{name}' => '#{default}'.") unless @env[:invade_validate_quiet]
          @validation_errors = @validation_errors + 1
          return default
        else
          @env[:ui].error("\tError: '#{value}' is not a string or array. Set to '#{name}' to default value '#{default}'.") unless @env[:invade_validate_quiet]
          @validation_errors = @validation_errors + 1
          return default
        end

        value
      end

      # Validates to INT and returns the value at success or a default if not
      def self.validate_integer(value, name, default)

        if value.is_a?(Integer) || is_number(value)
          @env[:ui].success("\t#{name} => #{value}") unless @env[:invade_validate_quiet]
        elsif value === nil
          @env[:ui].warn("\t#{name} not set. Use Vagrant default.") unless @env[:invade_validate_quiet]
          return default
        else
          @env[:ui].error("\tError: '#{value}' is not an integer. Set '#{name}' to default value #{default}.") unless @env[:invade_validate_quiet]
          @validation_errors = @validation_errors + 1
          return default
        end

        value
      end

      # Validates to ARRAY and returns the value at success or a default if not
      def self.validate_array(value, name, default)

        if value.is_a?(Array)
          @env[:ui].success("\t#{name} => #{value}") unless @env[:invade_validate_quiet]
        elsif value === nil
          @env[:ui].warn("\t#{name} not set. Use Vagrant default.") unless @env[:invade_validate_quiet]
          return default
        else
          @env[:ui].error("\tError: '#{value}' is not an array. Set '#{name}' to default value #{default}.") unless @env[:invade_validate_quiet]
          @validation_errors = @validation_errors + 1
          return default
        end

        value
      end

      # Validates to HASH and returns the value at success or a default if not
      def self.validate_hash(value, name, default)

        if value.is_a?(Hash)
          @env[:ui].success("\t#{name} => #{value}") unless @env[:invade_validate_quiet]
        elsif value === nil
          @env[:ui].warn("\t#{name} not set. Use Vagrant default.") unless @env[:invade_validate_quiet]
          return default
        else
          @env[:ui].error("\tError: '#{value}' is not a Hash. Set '#{name}' to default value #{default}.") unless @env[:invade_validate_quiet]
          @validation_errors = @validation_errors + 1
          return default
        end

        value
      end

      def self.get_validation_errors
        @validation_errors
      end

      def self.is_number(value)
        value.to_f.to_s == value.to_s || value.to_i.to_s == value.to_s
      end

    end
  end
end
