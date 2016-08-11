module VagrantPlugins
  module Invade
    module Builder

      require 'erubis'

      class Vagrantfile

        attr_reader :result
        attr_accessor :vagrantfile_data

        def initialize(vagrantfile_data, result: nil)
          @vagrantfile_data  = vagrantfile_data
          @result   = result
        end

        def build
          b = binding
          template_file = "#{TEMPLATE_PATH}/v2.erb"

          begin

            # Set variables for template files
            hostmanager = @vagrantfile_data['hostmanager']
            machines = @vagrantfile_data['machine']

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
