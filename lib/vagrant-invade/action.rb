module VagrantPlugins
  module Invade
    module Action
      include Vagrant::Action::Builtin

      def self.config
        Vagrant::Action::Builder.new.tap do |builder|
          require 'vagrant-invade/action/config'
          builder.use Config
        end
      end

    end
  end
end
