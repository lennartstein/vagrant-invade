module VagrantPlugins
  module Invade
    module Builder
      module Provider

        autoload :VirtualBox, 'vagrant-invade/builder/provider/virtualbox'
        autoload :VMware, 'vagrant-invade/builder/provider/vmware'

      end
    end
  end
end
