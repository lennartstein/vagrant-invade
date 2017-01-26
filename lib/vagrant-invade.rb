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
      invade_config_file = Dir.glob(Dir.pwd + "/invade.{yml,yaml}")
      invade_config = Hash.new

      # If sinlge file configuration for invade exists - use it
      if invade_config_file.any?
        invade_config = YAML.load_file(invade_config_file[0])
      end
      
      # Creates empty machine hash if it not exists
      if invade_config['machine'].nil?
        invade_config['machine'] = Hash.new
      end
      
      # Iterate over each machine definition in ./invade/ folder and deep merge it
      Dir.glob("#{Dir.pwd}/invade-*.{yml,yaml}") do |config|
        invade_config.deep_merge!(YAML.load_file(config))
      end

      # Clean hash from empty/nil values recursively
      invade_config = invade_config.deep_compact(exclude_blanks: true)

      invade_config
    end
  end
end
