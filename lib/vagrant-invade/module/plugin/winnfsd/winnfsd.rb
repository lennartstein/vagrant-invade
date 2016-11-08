module VagrantPlugins
  module Invade
    module InvadeModule
      module Plugin

        class WinNFSd < InvadeModule

          attr_reader :result
          attr_accessor :machine_name, :ui, :winnfsd_data

          def initialize(machine_name, ui, winnfsd_data, result: nil)
            @machine_name = machine_name
            @ui = ui
            @winnfsd_data = winnfsd_data
            @result = result
          end

          def build

            if !Vagrant.has_plugin?('vagrant-winnfsd')
              @ui.error("[Invade] Plugin 'vagrant-winnfsd' not installed but defined. Use 'vagrant plugin install vagrant-winnfsd' to install it.")
              @result = ''
            else

              b = binding
              template_file = "#{TEMPLATE_PATH}/plugin/winnfsd.erb"

              begin

                # Get machine name
                machine_name = @machine_name

                # Values for winnfsd section
                logging = @winnfsd_data['logging']
                uid = @winnfsd_data['uid']
                gid = @winnfsd_data['gid']

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
end
