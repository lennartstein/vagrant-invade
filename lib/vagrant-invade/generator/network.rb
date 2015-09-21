module VagrantPlugins
  module Invade
    module Generator
      class Network

        attr_reader :result
        attr_accessor :ui, :options

        def initialize(ui, options, result: nil)
          @ui       = ui
          @options  = options
          @result   = result
        end

        def build()
          require 'erb'
          template_file = Dir.pwd('../../template/network/network.erb')

          # Values for network section
          name  = options['name']
          url   = options['url']

          ERB.new(File.read(template_file).gsub(/^\s+/, ""), 0, "", "@result").result b
        end
      end
    end
  end
end
