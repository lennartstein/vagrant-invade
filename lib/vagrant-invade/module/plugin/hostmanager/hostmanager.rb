module VagrantPlugins
  module Invade
    module InvadeModule
      module Plugin

        class Hostmanager < InvadeModule

          attr_reader :result
          attr_accessor :machine_name, :ui, :hostmanager_data

          def initialize(machine_name, ui, hostmanager_data, result: nil)
            @machine_name = machine_name
            @hostmanager_data = hostmanager_data
            @ui = ui
            @result = result
          end

          def build

            if Vagrant.has_plugin?('vagrant-hostmanager')

              b = binding
              template_file = "#{TEMPLATE_PATH}/plugin/hostmanager.erb"

              begin

                # Get machine name
                machine_name = @machine_name

                # Values for hostmanager section
                enabled = @hostmanager_data['enabled']
                manage_host = @hostmanager_data['manage_host']
                ignore_private_ip = @hostmanager_data['ignore_private_ip']
                include_offline =@hostmanager_data['include_offline']
                aliases = @hostmanager_data['aliases']

                eruby = Erubis::Eruby.new(File.read(template_file))
                @result = eruby.result b
              rescue TypeError, SyntaxError, SystemCallError => e
                raise(e)
              end
            else
              @ui.error("[Invade] Plugin 'vagrant-hostmanager' not installed but defined. Use 'vagrant plugin install vagrant-hostmanager' to install it.")
              @result = ''
            end
          end
        end
      end
    end
  end
end
