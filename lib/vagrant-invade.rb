require 'bundler'

begin
  require 'vagrant'
rescue LoadError
  Bundler.require(:default, :development)
end

require 'vagrant-invade/config'
require 'vagrant-invade/plugin'
require 'vagrant-invade/command'

module VagrantPlugins
  module Invade

    public

    def self.get_invade_config
      #Loading Invade configuration settings from file
      @source_root = VagrantPlugins::Invade.source_root
      invade_config_file = "#{@source_root}/InvadeConfig.yml"

      if File.exist?(invade_config_file)
        begin
          @config_values = YAML.load_file(invade_config_file)
          puts @config_values
        rescue SyntaxError => e
          @logger.error e
        end
      else
        @config_values = UNSET_VALUE
      end

      @config_values
    end

    def self.source_root
      @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end
  end
end
