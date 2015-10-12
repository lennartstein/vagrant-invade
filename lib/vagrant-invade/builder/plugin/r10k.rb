require 'uri'

module VagrantPlugins
  module Invade
    module Builder
      module Plugin

        require 'erubis'

        class R10k

          attr_reader :result
          attr_accessor :machine_name, :ui, :r10k_data

          def initialize(machine_name, ui, r10k_data, result: nil)
            @machine_name = machine_name
            @ui = ui
            @r10k_data = r10k_data
            @result = result
          end

          def build

            unless Vagrant.has_plugin?('vagrant-r10k')
              @ui.error("[Invade] Plugin 'vagrant-r10k' not installed but defined. Use 'vagrant plugin install vagrant-r10k' to install it.")
              @result = ""
            else

            b = binding
            template_file = "#{TEMPLATE_PATH}/plugin/r10k.erb"

              begin

                # Only generate puppetfile if modules are given in configuration file
                if @r10k_data['enabled'] && @r10k_data['modules']

                  basic_modules = [
                    %w(https://github.com/puppetlabs/puppetlabs-stdlib.git),
                    %w(https://github.com/puppetlabs/puppetlabs-apt.git),
                    %w(https://github.com/example42/puppi.git)
                  ]

                  puppetfile_path = File.expand_path(@r10k_data['puppetfile_path'])

                  # Generate Puppetfile
                  merged_modules = concat_module_array(basic_modules, @r10k_data['modules'])
                  build_puppetfile(merged_modules, puppetfile_path)
                end

                # Get machine name
                machine_name = @machine_name

                # Values for r10k section
                enabled = @r10k_data['enabled']
                puppet_dir = @r10k_data['puppet_dir']
                puppetfile_path = @r10k_data['puppetfile_path']
                module_path = @r10k_data['module_path']

                eruby = Erubis::Eruby.new(File.read(template_file))
                @result = eruby.result b
              rescue TypeError, SyntaxError, SystemCallError => e
                raise(e)
              end
            end
          end

          private

          def build_puppetfile(modules, puppetfile)

            begin
              if File.exist?(puppetfile)
                  File.delete(puppetfile)
              end

              File.open(puppetfile, 'w+') {|f| f.write("#Modules\n") }

              modules.each_with_index do |moduleScript, index|
                File.open(puppetfile, 'a+') do |f|
                  f.puts generate_puppetfile_data(
                    modules[index][0],
                    module_version: modules[index][1],
                    module_name: modules[index][2]
                  )
                end
              end
            rescue StandardError => error
              print "\nIO failed: #{error}"
              raise
            end
          end

          # Concats an given Array with an other Array with data
          def concat_module_array(base_array, ext_array)
            unless ext_array.to_a.empty? || ext_array.to_a.nil?
              ext_array.each do |modules|
                base_array.push(modules.flatten)
              end
            end

            base_array
          end

          # Generates the Puppetfile needed by r10k plugin to download puppet modules
          def generate_puppetfile_data(module_url, module_version: nil, module_name: nil)

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

          # Gets module name from a repository URL
          def get_module_name_from_repo_url(repository_url)

            # URL must include '/'
            unless repository_url.include? '/'
              self.add_invade_text(
                  MESSAGE_EXIT,
                  sprintf(
                      "Invalid repository path: '%s'. Path must include username and repository name. Example: 'magneton/xmen-protocol'.",
                      repository_url
                  )
              )
            end

            # Get last part of the URI
            repository_name = URI(repository_url).path.split('/').last

            # Removes .git from name
            repository_name = repository_name.partition('.').first

            # Dashs in combination with lower dashs in a path are not allowed
            dash_count = repository_name.count('-')
            lower_dash_count = repository_name.count('_')

            if dash_count > 0 && lower_dash_count > 0
              self.add_invade_text(MESSAGE_EXIT,
                  sprintf(
                      "Invalid repository path: '%s'. It includes at least one dash and one lower dash. Can't generate a repository name. Please use the optional module_name paramater to manually define a name for this module.",
                      repository_name
                  )
              )
            else
              if dash_count > 0
                cut_character = '-'
                repository_name = repository_name.partition(cut_character).last
              elsif lower_dash_count > 0
                cut_character = '_'
                repository_name = repository_name.partition(cut_character).last
              else
                return repository_name
              end
            end

            repository_name
          end
        end
      end
    end
  end
end
