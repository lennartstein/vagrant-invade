module VagrantPlugins
  module Invade
    module Generator

      class HostManager

        attr_accessor :hostmanager_data

        def initialize(hostmanager_data)
          @hostmanager_data = hostmanager_data
        end

        def generate
          hostmanager = Builder::HostManager.new(@hostmanager_data)
          hostmanager.build

          hostmanager.result
        end

      end
    end
  end
end
