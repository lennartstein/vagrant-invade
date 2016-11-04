require 'rbconfig'

module VagrantPlugins
  module Invade
    module Validator
      module Provision

        # (see: https://docs.vagrantup.com/v2/provisioning/puppet_agent.html)
        class PuppetAgent

          attr_accessor :puppet_agent

          DEFAULT = {
            'puppet_server' => nil,
            'puppet_node' => nil,
            'client_cert_path' => nil,
            'client_private_key_path' => nil,
            'facter' => nil,
            'options' => nil
          }

          def initialize(puppet_agent)
            @puppet_agent = puppet_agent
          end

          def validate
            return nil unless @puppet_agent

            # PUPPET SERVER
            @puppet_agent['puppet_server'] = Validator.validate_string(
                @puppet_agent['puppet_server'], 'puppet_server', DEFAULT['puppet_server']
            )

            # PUPPET NODE
            @puppet_agent['puppet_node'] = Validator.validate_string(
                @puppet_agent['puppet_node'], 'puppet_node', DEFAULT['puppet_node']
            )

            # CLIENT CERT PATH
            @puppet_agent['client_cert_path'] = Validator.validate_array(
                @puppet_agent['client_cert_path'], 'client_cert_path', DEFAULT['client_cert_path']
            )

            # CLIENT PRIVATE KEY PATH
            @puppet_agent['client_private_key_path'] = Validator.validate_array(
                @puppet_agent['client_private_key_path'], 'client_private_key_path', DEFAULT['client_private_key_path']
            )

            # FACTER
            @puppet_agent['facter'] = Validator.validate_array(
                @puppet_agent['facter'], 'facter', DEFAULT['facter']
            )

            # OPTIONS
            @puppet_agent['options'] = Validator.validate_string(
                @puppet_agent['options'], 'options', DEFAULT['options']
            )

            @salt
          end
        end
      end
    end
  end
end
