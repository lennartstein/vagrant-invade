require 'vagrant-invade/plugin'
require 'vagrant-invade/version'
require 'vagrant-invade/extend'
require 'yaml'

module VagrantPlugins
  module Invade

    autoload :Validator, 'vagrant-invade/validator'
    autoload :InvadeModule, 'vagrant-invade/module'
    autoload :Generator, 'vagrant-invade/generator'
    autoload :Helper, 'vagrant-invade/helper'

    def self.get_invade_config

      #Loading Invade configuration settings from file
      invade_config_file = Dir.pwd + '/invade.yml'

      if File.exists?(invade_config_file)
        begin
          return YAML.load_file(invade_config_file)
        rescue SyntaxError => e
          @logger.error e
          fail e
        end
      else
        @config_values = nil
      end

      @config_values
    end
  end
end
