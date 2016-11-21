module VagrantPlugins
  module Invade
    module Module
      module Provision

        class PuppetAgent <  Module

          attr_reader :result
          attr_accessor :machine_name, :puppet_agent_data

          def initialize(machine_name, puppet_agent_data, result: nil)
            @machine_name = machine_name
            @puppet_agent_data = puppet_agent_data
            @result = result
          end

          def build
            b = binding

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for provider puppet_agent section
              puppet_server = @puppet_agent_data['puppet_server']
              puppet_node = @puppet_agent_data['puppet_node']
              client_cert_path = @puppet_agent_data['client_cert_path']
              client_private_key_path = @puppet_agent_data['client_private_key_path']
              facter = @puppet_agent_data['facter']
              options = @puppet_agent_data['options']

              eruby = Erubis::Eruby.new(File.read(self.get_template_path(__FILE__)))
              @result = eruby.result b
            rescue TypeError, SyntaxError, SystemCallError => e
              raise(e)
            end
          end
        end

      end
    end
  end
end
