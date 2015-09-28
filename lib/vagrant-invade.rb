require 'bundler'

begin
  require 'vagrant'
rescue LoadError
  Bundler.require(:default, :development)
end

require 'vagrant-invade/plugin'
require 'vagrant-invade/command'

module VagrantPlugins
  module Invade

    autoload :Generator, 'vagrant-invade/generator'
    autoload :Validator, 'vagrant-invade/validator'

    def self.get_invade_config
      #Loading Invade configuration settings from file
      @source_root = VagrantPlugins::Invade.source_root
      invade_config_file = "#{@source_root}/InvadeConfig.yml"

      if File.exist?(invade_config_file)
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

    def self.source_root
      @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end
  end
end
