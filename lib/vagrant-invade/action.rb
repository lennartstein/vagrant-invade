module VagrantPlugins
  module Invade
    module Action
      include Vagrant::Action::Builtin

      def self.invade
        Vagrant::Action::Builder.new.tap do |builder|
          require 'vagrant-invade/action/config'
          require 'vagrant-invade/action/validate'

          builder.use Config
          builder.use Validate
        end
      end
    end
  end
end
