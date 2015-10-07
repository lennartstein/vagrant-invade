module VagrantPlugins
  module Invade
    module Builder
      module Network
        require 'erubis'

        class ForwardedPort

          attr_reader :result
          attr_accessor :machine_name, :forwarded_port_data

          def initialize(machine_name, forwarded_port_data, result: nil)
            @machine_name = machine_name
            @forwarded_port_data  = forwarded_port_data
            @result   = result
          end

          def build
            b = binding
            template_file = "#{TEMPLATE_PATH}/network/forwarded_port.erb"

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for network section
              ip = @forwarded_port_data['ip']
              dhcp = @forwarded_port_data['dhcp']
              guest = @forwarded_port_data['guest']
              guest_ip = @forwarded_port_data['guest_ip']
              host = @forwarded_port_data['host']
              host_ip = @forwarded_port_data['host_ip']
              protocol = @forwarded_port_data['protocol']
              auto_correct = @forwarded_port_data['auto_correct']

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
end
