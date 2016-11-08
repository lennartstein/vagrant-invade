module VagrantPlugins
  module Invade
    module Module
      module Provision

        autoload :Shell, 'vagrant-invade/module/provision/shell/shell'
        autoload :ShellInline, 'vagrant-invade/module/provision/shell_inline/shell_inline'
        autoload :PuppetApply, 'vagrant-invade/module/provision/puppet_apply/puppet_apply'
        autoload :PuppetAgent, 'vagrant-invade/module/provision/puppet_agent/puppet_agent'
        autoload :Salt, 'vagrant-invade/module/provision/salt/salt'

      end
    end
  end
end
