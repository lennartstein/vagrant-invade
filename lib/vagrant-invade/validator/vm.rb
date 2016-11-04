module VagrantPlugins
  module Invade
    module Validator

      class VM

        attr_accessor :vm

        DEFAULT = {
          'box' => 'invade/default',
          'url' => nil,
          'hostname' => 'invade.vm'
        }

        def initialize(vm)
          @vm = vm
        end

        def validate
          return DEFAULT unless @vm

          # BOX NAME (usually repository name of vm on Atlas (http://atlas.hashicorp.com))
          @vm['box'] = Validator.validate_string(
            @vm['box'], 'box', DEFAULT['box']
          )

          # BOX URL
          @vm['url'] = Validator.validate_string(
            @vm['url'], 'url', DEFAULT['url']
          )

          # BOX URL
          @vm['hostname'] = Validator.validate_string(
            @vm['hostname'], 'hostname', DEFAULT['hostname']
          )

          @vm
        end

      end
    end
  end
end
