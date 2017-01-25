module VagrantPlugins
  module Invade
    module Helper

      class Checksum

        attr_accessor :data, :root_path, :vagrantfile

        def initialize(data)
          @data         = data
          @root_path    = Dir.pwd
          @vagrantfile  = ENV['VAGRANT_VAGRANTFILE'] ? vagrantfile_name = ENV['VAGRANT_VAGRANTFILE'] : vagrantfile_name = "Vagrantfile"
        end

        # Compare Vagrantfile <=> invade.yml with MD5 checksum
        def check()

          # Create checksum from generated data of invade.yml file
          require 'digest'
          md5_new = Digest::MD5.hexdigest(@data)

          unless (md5_new.eql? get_checksum_of_file(@vagrantfile))
            return false
          end

          true
        end

        def get_checksum_of_data(data)

          begin
            checksum = Digest::MD5.hexdigest(@data)
          rescue StandardError => e
            fail e
          end

          checksum
        end

        def get_checksum_of_file(file)

          begin
            if File.exist?(file)
              return Digest::MD5.file(file).hexdigest
            end
          rescue IOError => e
            fail e
          end

          0
        end

      end

    end
  end
end
