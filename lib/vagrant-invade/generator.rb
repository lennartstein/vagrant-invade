module VagrantPlugins
  module Invade
    module Generator

      autoload :HostManager, 'vagrant-invade/generator/hostmanager'
      autoload :MachinePart, 'vagrant-invade/generator/machine_part'
      autoload :Machine, 'vagrant-invade/generator/machine'
      autoload :Vagrantfile, 'vagrant-invade/generator/vagrantfile'

    end
  end
end
