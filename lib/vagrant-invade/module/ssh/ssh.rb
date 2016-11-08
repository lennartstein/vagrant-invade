module VagrantPlugins
  module Invade
    module InvadeModule

      class Ssh < InvadeModule

        attr_reader :result
        attr_accessor :machine_name, :ssh_data

        def initialize(machine_name, ssh_data, result: nil)
          @machine_name = machine_name
          @ssh_data  = ssh_data
          @result   = result
        end

        def build
          b = binding
          template_file = "#{TEMPLATE_PATH}/ssh/ssh.erb"

          begin

            # Get machine name
            machine_name = @machine_name

            # Values for vm section
            forward_agent = @ssh_data['forward_agent']
            enabled = @ssh_data['enabled']
            path = @ssh_data['path']

            eruby = Erubis::Eruby.new(File.read(template_file))
            @result = eruby.result b
          rescue TypeError, SyntaxError, SystemCallError => e
            raise(e)
          end
        end
      end

    end
  end
end
