require 'pathname'
require 'vagrant/action/builder'

module VagrantPlugins
  module Invade
    module Action

      def self.build
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use Config
          builder.use Process
          builder.use Create
        end
      end

      # This middleware sequence will validate and build the invade configuration file
      def self.process
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use Config
          builder.use Process
        end
      end

      # This middleware sequence will init a InVaDE configuration file
      def self.init
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use Init
        end
      end

      def self.check
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use Config
          builder.use Process
          builder.use Check
        end
      end

      # The autoload farm
      action_root = Pathname.new(File.expand_path('../action', __FILE__))
      autoload :Init, action_root.join('init')
      autoload :Config, action_root.join('config')
      autoload :Process, action_root.join('process')
      autoload :Create, action_root.join('create')
      autoload :Check, action_root.join('check')

    end
  end
end
