module VagrantPlugins
  module Invade
    module Builder
      module Provider

        autoload :VirtualBox, 'vagrant-invade/builder/provider/virtualbox.rb'
        autoload :VMware, 'vagrant-invade/builder/provider/vmware.rb'

      end
    end
  end
end
