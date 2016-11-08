module VagrantPlugins
  module Invade
    module InvadeModule
      module Network

        autoload :ForwardedPort, 'vagrant-invade/module/network/forwarded_port/forwarded_port'
        autoload :Private, 'vagrant-invade/module/network/private/private'
        autoload :Public, 'vagrant-invade/module/network/public/public'

      end
    end
  end
end
