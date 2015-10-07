module VagrantPlugins
  module Invade
    module Builder
      module Network

        autoload :ForwardedPort, 'vagrant-invade/builder/network/forwarded_port.rb'
        autoload :PrivateNetwork, 'vagrant-invade/builder/network/private_network.rb'
        autoload :PublicNetwork, 'vagrant-invade/builder/network/public_network.rb'

      end
    end
  end
end
