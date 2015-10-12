require 'vagrant'

module VagrantPlugins
  module Invade
    class Plugin < Vagrant.plugin('2')
      name 'invade command'
      description 'This plugin configures Vagrant for you'

      command('invade') do
        require File.expand_path("../command/root", __FILE__)
        Command::Root
      end

      # Disable hook for now. Use commands instead of auto mode

      # Hook - Do all the invade magic before Vagrant itself comes alive
      # action_hook(:invade, :machine_action_up) do |hook|
      #   require 'vagrant-invade/action'
      #
      #   # 1. Checks config file
      #   # 2. Validates config file
      #   # 3. Generates Vagrantfile from invade config
      #   # 4. Creates generated Vagrantfile
      #   hook.prepend(Action.build)
      # end
    end

    autoload :Action, File.expand_path("../action/", __FILE__)
  end
end
