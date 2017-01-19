module VagrantPlugins
  module Invade
    module InvadeModule
      module SyncedFolder

        class Nfs < InvadeModule

          attr_reader :result
          attr_accessor :machine_name, :nfs_data

          def initialize(machine_name, nfs_data, result: nil)
            @machine_name = machine_name
            @nfs_data  = nfs_data
            @result = result
          end

          def build
            b = binding

            begin

              # Get machine name
              machine_name = @machine_name

              # Values for provider sections
              enabled = @nfs_data['enabled']
              uid = @nfs_data['uid']
              gid = @nfs_data['gid']
              source = @nfs_data['source']
              path = @nfs_data['path']
              mount_options = @nfs_data['mount_options']
              linux__nfs_options = @nfs_data['linux__nfs_options']
              bsd__nfs_options = @nfs_data['bsd__nfs_options']
              nfs_version = @nfs_data['nfs_version']
              nfs_udp = @nfs_data['nfs_udp']

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
end
