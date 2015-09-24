module VagrantPlugins
  module Invade
    module Generator

      autoload :Box, 'vagrant-invade/generator/box'
      autoload :Network, 'vagrant-invade/generator/network'
      autoload :Provider, 'vagrant-invade/generator/provider'

      TEMPLATE_PATH = File.join(File.dirname(__FILE__), 'template')

    end
  end
end
