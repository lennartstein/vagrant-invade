module VagrantPlugins
  module Invade
    module InvadeModule
      module Provision

        autoload :Ansible, 'vagrant-invade/module/provision/ansible/ansible'
        autoload :AnsibleLocal, 'vagrant-invade/module/provision/ansible_local/ansible_local'
        autoload :PuppetApply, 'vagrant-invade/module/provision/puppet_apply/puppet_apply'
        autoload :PuppetAgent, 'vagrant-invade/module/provision/puppet_agent/puppet_agent'
        autoload :Salt, 'vagrant-invade/module/provision/salt/salt'
        autoload :Shell, 'vagrant-invade/module/provision/shell/shell'

      end
    end
  end
end
