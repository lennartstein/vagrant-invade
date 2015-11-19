module VagrantPlugins
  module Invade
    module Builder
      module SSH

        require 'erubis'

        class ForwardAgent

          attr_reader :result
          attr_accessor :machine_name, :forward_agent

          def initialize(machine_name, forward_agent, result: nil)
            @machine_name = machine_name
            @forward_agent = forward_agent
            @result = result
          end

          def build
            b = binding
            template_file = "#{TEMPLATE_PATH}/ssh/ssh.erb"

            begin
              # Get machine name
              machine_name = @machine_name
              forward_agent = @forward_agent

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
