module VagrantPlugins
  module Invade
    module Generator
      
      module MachinePart

        autoload :VM, 'vagrant-invade/generator/machine_part/vm'
        autoload :Network, 'vagrant-invade/generator/machine_part/network'
        autoload :SSH, 'vagrant-invade/generator/machine_part/ssh'
        autoload :Provider, 'vagrant-invade/generator/machine_part/provider'
        autoload :SyncedFolder, 'vagrant-invade/generator/machine_part/synced_folder'
        autoload :Provision, 'vagrant-invade/generator/machine_part/provision'
        autoload :Plugin, 'vagrant-invade/generator/machine_part/plugin'

        attr_accessor :machine_part

        def initialize(machine_part)

        end
      end
    end
  end
end
