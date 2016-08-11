module VagrantPlugins
  module Invade
    module Generator
      module MachinePart

        class Provision

          attr_accessor :machine_name, :name, :provision_data

          def initialize(machine_name, name, provision_data)
            @machine_name = machine_name
            @name = name
            @provision_data = provision_data
          end

          def generate
            case @provision_data['type']
            when 'shell'
              provision = Builder::Provision::Shell.new(@machine_name, @name, @provision_data)
            when 'shell-inline', 'inline', 'shellinline'
              provision = Builder::Provision::ShellInline.new(@machine_name, @name, @provision_data)
            when 'puppet', 'puppetapply', 'puppet-apply'
              provision = Builder::Provision::PuppetApply.new(@machine_name, @provision_data)
            when 'puppet-agent', 'puppetagent'
              provision = Builder::Provision::PuppetAgent.new(@machine_name, @provision_data)
            else
              raise StandardError, "Provisioner unknown or not set. Please check the provision configuration."
            end

            provision.build

            provision.result
          end

        end

      end
    end
  end
end
