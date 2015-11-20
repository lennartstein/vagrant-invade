module VagrantPlugins
  module Invade
    module Builder

      require 'erubis'

      class Definition

        attr_reader :result
        attr_accessor :definition_data

        def initialize(machine_name, definition_data, result: nil)
          @machine_name = machine_name
          @definition_data  = definition_data
          @result   = result
        end

        def build
          b = binding
          template_file = "#{TEMPLATE_PATH}/definition.erb"

          begin

            # Machine name
            machine_name = @machine_name

            # Data to build definition entry
            vm = @definition_data['vm']
            network = @definition_data['network']
            ssh = @definition_data['ssh']
            provider = @definition_data['provider']
            synced_folder = @definition_data['synced_folder']
            plugin = @definition_data['plugin']
            provision = @definition_data['provision']

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
