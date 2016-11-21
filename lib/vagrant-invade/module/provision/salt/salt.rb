module VagrantPlugins
  module Invade
    module Module
      module Provision

        class Salt < Module

          attr_reader :result
          attr_accessor :machine_name, :salt_data

          def initialize(machine_name, salt_data, result: nil)
            @machine_name = machine_name
            @salt_data = salt_data
            @result = result
          end

          def build
            b = binding

            begin

              # Get machine name
              machine_name = @machine_name

              # salt install options
              install_master = @salt_data['install_master']
              no_minion = @salt_data['no_minion']
              install_syncdir = @salt_data['install_syncdir']
              install_type = @salt_data['install_type']
              install_args = @salt_data['install_args']
              always_install = @salt_data['always_install']
              bootstrap_script = @salt_data['bootstrap_script']
              bootstrap_options = @salt_data['bootstrap_options']
              version = @salt_data['version']

              # salt minion options
              minion_config = @salt_data['minion_config']
              minion_key = @salt_data['minion_key']
              minion_id = @salt_data['minion_id']
              minion_pub = @salt_data['minion_pub']
              grains_config = @salt_data['grains_config']
              masterless = @salt_data['masterless']

              # salt master options
              master_config = @salt_data['master_config']
              master_key = @salt_data['master_key']
              master_pub = @salt_data['master_pub']
              seed_master = @salt_data['seed_master']

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
