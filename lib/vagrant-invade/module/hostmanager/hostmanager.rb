module VagrantPlugins
  module Invade
    module InvadeModule

      class Hostmanager < InvadeModule

        attr_reader :result
        attr_accessor :hostmanager_data

        def initialize(hostmanager_data, result: nil)
          @hostmanager_data = hostmanager_data
          @result = result
        end

        def build
          b = binding

          begin

            # Values for hostmanager part
            enabled = @hostmanager_data['enabled']
            manage_host = @hostmanager_data['manage_host']
            manage_guest = @hostmanager_data['manage_guest']
            ignore_private_ip = @hostmanager_data['ignore_private_ip']
            include_offline = @hostmanager_data['include_offline']

            eruby = Erubis::Eruby.new(File.read(self.get_template_path(__FILE__)))
            @result = eruby.result b
          rescue TypeError, SyntaxError, SystemCallError => e
            raise(e)
          end
        end
      end
    end
  end
end
