require 'uri'

module VagrantPlugins
  module Invade
    module InvadeModule
      module Plugin

        class R10k < InvadeModule

          attr_reader :result
          attr_accessor :machine_name, :ui, :r10k_data

          def initialize(machine_name, ui, r10k_data, result: nil)
            @machine_name = machine_name
            @ui = ui
            @r10k_data = r10k_data
            @result = result
          end

          def build

            if !Vagrant.has_plugin?('vagrant-r10k')
              @ui.error("[Invade] Plugin 'vagrant-r10k' not installed but defined. Use 'vagrant plugin install vagrant-r10k' to install it.")
              @result = ''
            else

              b = binding

              begin

                # Only generate puppetfile if plugin is enabled and modules are configured
                if @r10k_data['enabled'] && @r10k_data['modules']

                  # Configured puppet dir must exists. Otherwise skip generating Puppetfile.
                  if !Dir.exists?(@r10k_data['puppet_dir'])
                    @ui.error("[Invade] Puppet dir '#{@r10k_data['puppet_dir']}' does not exists. Can't load specified modules.")
                  else
                    basic_modules = {
                      'stdlib' => {
                        'url' => 'https://github.com/puppetlabs/puppetlabs-stdlib.git'
                      },
                      'apt' => {
                        'url' => 'https://github.com/puppetlabs/puppetlabs-apt.git'
                      },
                      'puppi' => {
                        'url' => 'https://github.com/example42/puppi.git'
                      }
                    }

                    puppetfile_path = File.expand_path(@r10k_data['puppetfile_path'])

                    # Generate Puppetfile
                    merged_modules = basic_modules.merge(@r10k_data['modules'])
                    generate_puppetfile(merged_modules, puppetfile_path)
                  end
                end

                # Get machine name
                machine_name = @machine_name

                # Values for r10k section
                enabled = @r10k_data['enabled']
                puppet_dir = @r10k_data['puppet_dir']
                puppetfile_path = @r10k_data['puppetfile_path']
                module_path = @r10k_data['module_path']

                eruby = Erubis::Eruby.new(File.read(self.get_template_path(__FILE__)))
                @result = eruby.result b
              rescue TypeError, SyntaxError, SystemCallError => e
                raise(e)
              end
            end
          end

          private

          # Generates a puppetfile needed by r10k plugin to manage dependencies
          def generate_puppetfile(modules, puppetfile)

            begin
              if File.exist?(puppetfile)
                  File.delete(puppetfile)
              end

              # Create file first and add header
              File.open(puppetfile, 'w+') {
                |f| f.write("#Modules\n")
              }

              modules.each do |name, module_data|
                File.open(puppetfile, 'a+') do |f|
                  f.puts parse_puppetfile_data(name, module_data['url'], module_version: module_data['version'])
                end
              end

            rescue StandardError => error
              print "\nIO failed: #{error}"
              raise
            end
          end

          # Parses the puppetfile data
          def parse_puppetfile_data(module_name, module_url, module_version: nil)

            # build name part
            if module_name.nil? || module_name.empty?
              module_name = get_module_name_from_repo_url(module_url)
            end

            definition = "mod '#{module_name}',"
            definition.concat("\n  :git => '#{module_url}'")

            # build version part
            unless module_version.nil? || module_version.empty?
              definition.concat(",\n  :ref => '#{module_version}'")
            end

            definition.concat("\n")
          end
        end
      end
    end
  end
end
