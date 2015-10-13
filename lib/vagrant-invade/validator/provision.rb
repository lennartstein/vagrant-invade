module VagrantPlugins
  module Invade
    module Validator

      # (see: https://docs.vagrantup.com/v2/provisioning/index.html)
      module Provision

        autoload :Shell, 'vagrant-invade/validator/provision/shell'
        autoload :ShellInline, 'vagrant-invade/validator/provision/shell_inline'
        #autoload :Ansible, 'vagrant-invade/validator/provision/ansible'
        #autoload :CFEngine, 'vagrant-invade/validator/provision/cfengine'
        #autoload :ChefSolo, 'vagrant-invade/validator/provision/chef_solo'
        #autoload :ChefZero, 'vagrant-invade/validator/provision/chef_zero'
        #autoload :ChefClient, 'vagrant-invade/validator/provision/chef_client'
        #autoload :ChefApply, 'vagrant-invade/validator/provision/chef_apply'
        #autoload :Docker, 'vagrant-invade/validator/provision/docker'
        autoload :PuppetApply, 'vagrant-invade/validator/provision/puppet_apply'
        autoload :PuppetAgent, 'vagrant-invade/validator/provision/puppet_agent'
        #autoload :Salt, 'vagrant-invade/validator/provision/salt'

      end
    end
  end
end
