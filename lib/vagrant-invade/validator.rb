module VagrantPlugins
  module Invade
    module Validator

      autoload :Invade, 'vagrant-invade/validator/invade'
      autoload :Box, 'vagrant-invade/validator/box'
      autoload :Network, 'vagrant-invade/validator/network'
      autoload :Provider, 'vagrant-invade/validator/provider'
      autoload :Provision, 'vagrant-invade/validator/provision'
      autoload :SyncedFolder, 'vagrant-invade/validator/synced_folder'
      autoload :SSH, 'vagrant-invade/validator/ssh'

      VALIDATION_ERRORS = 0

      attr_accessor :env
      attr_accessor :invade

      @env = nil
      @invade = nil

      def self.set_env(env)
        @env = env
      end

      def self.set_invade(env)
        @invade = env[:invade]['invade']
      end

      def self.validate(value, name, type, default)

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

      private

      # Validates to BOOLEAN and returns the value at success or a default if not
      def self.validate_boolean(value, name, default)

        invade = @env[:invade]['invade']

        if [true, false].include? value
          @env[:ui].success("\t#{name} => #{value}") if invade['debug']
        elsif value === nil
          @env[:ui].info("\tOption is not set. Set '#{name}' => #{default.to_s.upcase}.") if invade['debug']
          return default
        else
          @env[:ui].warn("\tWarning: #{name} => #{value} is not a boolean. Set '#{name}' to default value #{default.to_s.upcase}.")
          self.VALIDATION_ERRORS = self.VALIDATION_ERRORS + 1
          return default
        end

        value
      end

      # Validates to STRING and returns the value at success or a default if not
      def self.validate_string(value, name, default)

        invade = @env[:invade]['invade']

        if value.is_a? String
          @env[:ui].success("\t#{name} => '#{value}'") if @env[:invade]['debug']
        elsif value === nil
          @env[:ui].info("\tOption is not set. Set '#{name}' => '#{default}'.") if invade['debug']
          return default
        elsif value === ''
          @env[:ui].warn("\tEmpty string is not valid. Set '#{name}' => '#{default}'.") if invade['debug']
          return default
        else
          @env[:ui].warn("\tWarning: '#{value}' is not a string. Set to '#{name}' to default value '#{default}'.")
          self.VALIDATION_ERRORS = self.VALIDATION_ERRORS + 1
          return default
        end

        value
      end

      # Validates to INT and returns the value at success or a default if not
      def self.validate_integer(value, name, default)

        invade = @env[:invade]['invade']

        if value.is_a? Integer or is_number(value)
          @env[:ui].success("\t#{name} => #{value}") if invade['debug']
        elsif value === nil
          @env[:ui].info("\tOption is not set. Set '#{name}' => '#{default}'.") if invade['debug']
          return default
        else
          @env[:ui].warn("\tWarning: '#{value}' is not an integer. Set '#{name}' to default value #{default}.")
          self.VALIDATION_ERRORS = self.VALIDATION_ERRORS + 1
          return default
        end

        value
      end

      # Validates to ARRAY and returns the value at success or a default if not
      def self.validate_array(value, name, default)

        if value.is_a? Array
          @env[:ui].success("\t#{name} => #{value}") if invade['debug']
        elsif value === nil
          @env[:ui].info("\tOption is not set. Set '#{name}' => '#{default}'.")  if invade['debug']
          return default
        else
          @env[:ui].warn("\tWarning: '#{value}' is not an array. Set '#{name}' to default value #{default}.")
          self.VALIDATION_ERRORS = self.VALIDATION_ERRORS + 1
          return default
        end

        value
      end

      def self.is_number(value)
        value.to_f.to_s == value.to_s || value.to_i.to_s == value.to_s
      end

    end
  end
end
