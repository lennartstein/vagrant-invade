module VagrantPlugins
  module Invade
    module InvadeModule
      module Vagrant

        class Vagrantfile < InvadeModule

          attr_reader :result
          attr_accessor :vagrantfile_data

          def initialize(vagrantfile_data, result: nil)
            @vagrantfile_data  = vagrantfile_data
            @result   = result
          end

          def build
            b = binding

            begin

              # Set variables for template files
              global_hostmanager = @vagrantfile_data['hostmanager']
              global_nfs = @vagrantfile_data['nfs']
              machine = @vagrantfile_data['machine']

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
