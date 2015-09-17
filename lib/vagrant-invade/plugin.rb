
module VagrantPlugins
  module Invade
    class Plugin < Vagrant.plugin('2')
      name 'Invade'
      description 'This plugin configures Vagrant for you'
      command 'invade' do
        require_relative 'command'
        Command
      end

      # Hook - Do all the invade magic before Vagrant itself comes alive
      action_hook(:invade, :machine_action_up) do |hook|
        require 'vagrant-invade/action'

        # 1. Checks config file
        # 2. Validates config file
        # 3. Generates Vagrantfile from invade config
        hook.prepend(Action.invade)
      end
    end
  end
end
