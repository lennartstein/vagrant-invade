module VagrantPlugins
  module Invade
    module Generator
      module Provider

        require 'erb'

        class VirtualBox

          attr_reader :result
          attr_accessor :machine_name, :options

          def initialize(machine_name, options, result: nil)
            @machine_name = machine_name
            @options  = options
            @result   = result
          end

          def build
            b = binding
            template_file = "#{TEMPLATE_PATH}/provider/virtualbox.erb"

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for provider section
              name      = @options['name']
              type      = @options['type']
              cores     = @options['cores']
              memory    = @options['memory']
              nicspeed  = @options['nicspeed']
              natdns    = @options['natdns']

              ERB.new(File.read(template_file), 0, "-", "@result").result b
            rescue TypeError, SyntaxError, SystemCallError => e
              raise(e)
            end
          end
        end

      end
    end
  end
end
