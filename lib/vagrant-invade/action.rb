module VagrantPlugins
  module Invade
    module Action
      include Vagrant::Action::Builtin

      def self.invade
        Vagrant::Action::Builder.new.tap do |builder|
          require 'vagrant-invade/action/config'
          require 'vagrant-invade/action/validate'
          require 'vagrant-invade/action/generate'

          builder.use Config
          builder.use Validate
          builder.use Generate
        end
      end
    end
  end
end
