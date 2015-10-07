module VagrantPlugins
  module Invade
    module Builder
      module Provision

        autoload :Shell, 'vagrant-invade/builder/provision/shell.rb'
        autoload :Puppet, 'vagrant-invade/builder/provision/puppet.rb'

      end
    end
  end
end
