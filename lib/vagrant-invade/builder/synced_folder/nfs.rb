module VagrantPlugins
  module Invade
    module Builder
      module SyncedFolder

        require 'erubis'

        class NFS

          attr_reader :result
          attr_accessor :machine_name, :nfs_data

          def initialize(machine_name, nfs_data, result: nil)
            @machine_name = machine_name
            @nfs_data  = nfs_data
            @result = result
          end

          def build
            b = binding
            template_file = "#{TEMPLATE_PATH}/synced_folder/nfs.erb"

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for provider sections
              enabled = !@nfs_data['enabled'] # negated because Vagrant asks if it is disabled
              uid = @nfs_data['uid']
              gid = @nfs_data['gid']
              source = @nfs_data['source']
              path = @nfs_data['path']
              mount_options = @nfs_data['mount_options']

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
