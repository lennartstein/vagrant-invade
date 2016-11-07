module VagrantPlugins
  module Invade
    module Builder
      module Provision

        autoload :Shell, 'vagrant-invade/builder/provision/shell'
        autoload :ShellInline, 'vagrant-invade/builder/provision/shell_inline'
        autoload :PuppetApply, 'vagrant-invade/builder/provision/puppet_apply'
        autoload :PuppetAgent, 'vagrant-invade/builder/provision/puppet_agent'
        autoload :Salt, 'vagrant-invade/builder/provision/salt'

      end
    end
  end
end
