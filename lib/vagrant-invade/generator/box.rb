module VagrantPlugins
  module Invade
    module Generator

      require 'erb'
      require 'erubis'

      class Box

        attr_reader :result
        attr_accessor :ui, :options

        def initialize(ui, options, result: nil)
          @ui       = ui
          @options  = options
          @result   = result
          @templates_path = File.join(File.dirname(__FILE__), '../template')
        end

        def build
          b = binding
          template_file = "#{@templates_path}/box/box.erb"

          # Values for box section
          name  = options['name']
          url   = options['url']


          ERB.new(File.read(template_file).gsub(/^\s+/, ""), 0, "-", "@result").result b
        end
      end
    end
  end
end
