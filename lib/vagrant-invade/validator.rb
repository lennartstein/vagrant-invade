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

      # Validates to BOOLEAN and returns the value at success or a default if not
      def self.validate_boolean(value, name, default)

        invade = @env[:invade]['invade']

        if [true, false].include? value
          @env[:ui].success("\t#{name} => #{value}") unless @env[:invade_command_quiet]
        elsif value === nil
          @env[:ui].warn("\t#{name} not set. Use Vagrant default.") unless @env[:invade_command_quiet]
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
          @env[:ui].success("\t#{name} => '#{value}'") unless @env[:invade_command_quiet]
        elsif value === nil
          @env[:ui].warn("\t#{name} not set. Use Vagrant default.") unless @env[:invade_command_quiet]
          return default
        elsif value === ''
          @env[:ui].warn("\tEmpty string is not valid. Set '#{name}' => '#{default}'.") unless @env[:invade_command_quiet]
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
          @env[:ui].success("\t#{name} => #{value}") unless @env[:invade_command_quiet]
        elsif value === nil
          @env[:ui].warn("\t#{name} not set. Use Vagrant default.") unless @env[:invade_command_quiet]
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
          @env[:ui].success("\t#{name} => #{value}") unless @env[:invade_command_quiet]
        elsif value === nil
          @env[:ui].warn("\t#{name} not set. Use Vagrant default.") unless @env[:invade_command_quiet]
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
