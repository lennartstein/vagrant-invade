require 'pathname'
require 'vagrant/action/builder'

module VagrantPlugins
  module Invade
    module Action

      # This middleware sequence will only validate the invade configuration file
      def self.validate
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use Config
          builder.use Validate
        end
      end

      # This middleware sequence will validate and build the Vagrantfile
      def self.build
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use Config
          builder.use Validate
          builder.use Generate
          builder.use Create
        end
      end

      # The autoload farm
      action_root = Pathname.new(File.expand_path("../action", __FILE__))
      autoload :Config, action_root.join("config")
      autoload :Validate, action_root.join("validate")
      autoload :Generate, action_root.join("generate")
      autoload :Create, action_root.join("create")
    end
  end
end
