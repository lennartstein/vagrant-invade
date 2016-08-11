module VagrantPlugins
  module Invade
    module Generator

      class Vagrantfile

        attr_accessor :vagrantfile_data

        def initialize(vagrantfile_data)
          @vagrantfile_data = vagrantfile_data
        end

        def generate
          vagrantfile = Builder::Vagrantfile.new(@vagrantfile_data)
          vagrantfile.build

          vagrantfile.result
        end

      end
    end
  end
end
