
module VagrantPlugins
  module Invade
    class Plugin < Vagrant.plugin('2')
      name 'Invade'
      description 'This plugin configures Vagrant for you'
      command 'invade' do
        require_relative 'command'
        Command
      end

      # Configuration
      config(:invade) do
        require 'yaml'
        require_relative 'config'
        Config
      end

      # Hook - Check configuration of Invade before doing a "vagrant up"
      action_hook(:invade, :machine_action_up) do |hook|
        require 'vagrant-invade/action'
        hook.prepend(Action.config)
      end
    end
  end
end
