module VagrantPlugins
  module Invade
    module Builder
      module Network

        autoload :ForwardedPort, 'vagrant-invade/builder/network/forwarded_port'
        autoload :PrivateNetwork, 'vagrant-invade/builder/network/private_network'
        autoload :PublicNetwork, 'vagrant-invade/builder/network/public_network'

      end
    end
  end
end
