
module VagrantPlugins
  module Invade
    class Plugin < Vagrant.plugin('2')
      name 'Invade'
      description 'This plugin configures Vagrant for you'
      command 'invade' do
        require_relative 'command'
        Command
      end

      # Hook - Check and update the Vagrantfile with Invade before an "up"
      action_hook(:invade, :machine_action_up) do |hook|
        require 'vagrant-invade/action'
        hook.prepend(Action.config)
        # hook.prepend(Action.validate)
      end
    end
  end
end
