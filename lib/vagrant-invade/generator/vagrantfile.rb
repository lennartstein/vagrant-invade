module VagrantPlugins
  module Invade
    module Generator

      require 'erb'

      class Vagrantfile

        attr_reader :result
        attr_accessor :machine_name, :sections

        def initialize(machine_name, sections, result: nil)
          @machine_name = machine_name
          @sections  = sections
          @result   = result
        end

        def build
          b = binding
          template_file = "#{TEMPLATE_PATH}/v2.erb"

          begin

            # Get machine name
            machine_name = @machine_name

            # Sections for vagrantfile to generate
            box       = @sections['box']
            network   = @sections['network']
            vm        = @sections['vm']
            sf        = @sections['sf']
            provision = @sections['provision']

            ERB.new(File.read(template_file), 0, '-', '@result').result b
          rescue TypeError, SyntaxError, SystemCallError => e
            raise(e)
          end
        end
      end
    end
  end
end
