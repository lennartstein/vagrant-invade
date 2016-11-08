module VagrantPlugins
  module Invade
    module InvadeModule
      module Provider

        autoload :Virtualbox, 'vagrant-invade/module/provider/virtualbox/virtualbox'
        autoload :Vmware, 'vagrant-invade/module/provider/vmware/vmware'

      end
    end
  end
end
