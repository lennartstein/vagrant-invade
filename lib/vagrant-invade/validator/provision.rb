module VagrantPlugins
  module Invade
    module Validator
      module Provision

        autoload :Shell, 'vagrant-invade/validator/provision/shell'
        autoload :Puppet, 'vagrant-invade/validator/provision/puppet'
        #autoload :Chef, 'vagrant-invade/validator/provision/chef'
        #autoload :Docker, 'vagrant-invade/validator/provision/docker'

        DEFAULT = {}

        def self.validate_base(env, provision)
          return nil unless provision

          provision
        end
      end
    end
  end
end
