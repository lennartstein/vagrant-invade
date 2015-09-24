module VagrantPlugins
  module Invade
    module Generator
      module Provider

        autoload :virtualbox, 'vagrant-invade/generator/provider/virtualbox.rb'
        autoload :vmware, 'vagrant-invade/generator/provider/vmware.rb'

      end
    end
  end
end
