module VagrantPlugins
  module Invade
    module Builder

      require 'erubis'

      class Vagrantfile

        attr_reader :result
        attr_accessor :definitions

        def initialize(definitions, result: nil)
          @definitions  = definitions
          @result   = result
        end

        def build
          b = binding
          template_file = "#{TEMPLATE_PATH}/v2.erb"

          begin

            # definitions for vagrantfile to build
            definitions = @definitions

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
