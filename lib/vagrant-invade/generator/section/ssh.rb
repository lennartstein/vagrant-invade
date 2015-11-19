module VagrantPlugins
  module Invade
    module Generator
      module Section

        class SSH

          attr_accessor :machine_name, :type, :ssh_data

          def initialize(machine_name, type, ssh_data)
            @machine_name = machine_name
            @type = type
            @ssh_data = ssh_data
          end

          def generate

            case @type
              when 'forward_agent'
                ssh = Builder::SSH::ForwardAgent.new(@machine_name, @ssh_data)
            end

            ssh.build

            ssh.result
          end

        end
      end
    end
  end
end
