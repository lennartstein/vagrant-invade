module VagrantPlugins
  module Invade
    module InvadeModule

      class Nfs < InvadeModule

        attr_reader :result
        attr_accessor :nfs

        def initialize(nfs, result: nil)
          @nfs = nfs
          @result = result
        end

        def build
          b = binding

          begin

            # Values for nfs part
            functional = @nfs['functional']
            map_uid = @nfs['map_uid']
            map_gid = @nfs['map_gid']
            verify_installed = @nfs['verify_installed']

            map_uid ||= Process.uid
            map_gid ||= Process.gid

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
