module VagrantPlugins
  module Invade
    module Validator
      module Network

        autoload :ForwardedPort, 'vagrant-invade/validator/network/forwarded_port'
        autoload :PrivateNetwork, 'vagrant-invade/validator/network/private_network'
        autoload :PublicNetwork, 'vagrant-invade/validator/network/public_network'

      end
    end
  end
end
