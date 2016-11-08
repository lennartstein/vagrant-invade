module VagrantPlugins
  module Invade
    module Module
      module Provision

        class ShellInline < Module

          attr_reader :result
          attr_accessor :machine_name, :name, :shell_inline_data

          def initialize(machine_name, name, shell_inline_data, result: nil)
            @machine_name = machine_name
            @shell_inline_name = name
            @shell_inline_data = shell_inline_data
            @result = result
          end

          def build
            b = binding
            template_file = "#{TEMPLATE_PATH}/provision/shell_inline.erb"

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for shell provision section
              name = @shell_inline_name
              inline = @shell_inline_data['inline']
              binary = @shell_inline_data['binary']
              privileged = @shell_inline_data['privileged']

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
