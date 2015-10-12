module VagrantPlugins
  module Invade
    module Generator
      module Section

        class Plugin

          attr_accessor :machine_name, :type, :plugin_data

          def initialize(machine_name, type, plugin_data)
            @machine_name = machine_name
            @type = type
            @plugin_data = plugin_data
          end

          def generate
            case @type
            when 'hostmanager'
              plugin = Builder::Plugin::HostManager.new(@machine_name, @plugin_data)
            when 'winnfsd'
              plugin = Builder::Plugin::WinNFSd.new(@machine_name, @plugin_data)
            when 'r10k'
              plugin = Builder::Plugin::R10k.new(@machine_name, @plugin_data)
            else
              raise StandardError, "Plugin unknown or not set. Please check the plugin configuration."
            end

            plugin.build

            plugin.result
          end

        end

      end
    end
  end
end
