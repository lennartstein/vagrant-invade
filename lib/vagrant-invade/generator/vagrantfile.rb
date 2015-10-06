module VagrantPlugins
  module Invade
    module Generator

      class Vagrantfile

        attr_accessor :env, :vagrantfile_data

        def initialize(env, vagrantfile_data)
          @env = env
          @vagrantfile_data = vagrantfile_data
        end

        def generate
          require 'digest'

          vagrantfile = Builder::Vagrantfile.new(@vagrantfile_data)
          vagrantfile.build

          # Get project root and default vagrantfile filename
          ENV['VAGRANT_VAGRANTFILE'] ? vagrantfile_name = ENV['VAGRANT_VAGRANTFILE'] : vagrantfile_name = "Vagrantfile"
          currentVagrantfile = "#{@env[:root_path]}/#{vagrantfile_name}"

          # Compare md5 strings to replace Vagrantfile only if content changed
          md5_new = Digest::MD5.hexdigest(vagrantfile.result)
          md5_current = Digest::MD5.file(currentVagrantfile).hexdigest

          unless md5_new.equal? md5_current

            open("#{currentVagrantfile}", 'w+') do |f|
              f.puts vagrantfile.result
            end

            @env[:ui].warn '[Invade] Restarting Vagrant with new Vagrantfile...'
            # sleep 2
            #
            # if !Vagrant.in_installer? && !Vagrant.very_quiet?
            #   Kernel.exec('bundle exec vagrant up')
            # else
            #   Kernel.exec('vagrant up')
            # end

          end

        end

      end
    end
  end
end
