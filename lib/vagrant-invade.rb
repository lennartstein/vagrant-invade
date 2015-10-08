require 'bundler'

begin
  require 'vagrant'
rescue LoadError
  Bundler.require(:default, :development)
end

require 'vagrant-invade/plugin'

module VagrantPlugins
  module Invade

    autoload :Validator, 'vagrant-invade/validator'
    autoload :Builder, 'vagrant-invade/builder'
    autoload :Generator, 'vagrant-invade/generator'

    def self.get_invade_config
      #Loading Invade configuration settings from file
      @source_root = VagrantPlugins::Invade.source_root
      invade_config_file = "#{@source_root}/invade.yml"

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
