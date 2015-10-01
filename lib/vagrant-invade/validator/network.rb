module VagrantPlugins
  module Invade
    module Validator

      class Network

        attr_accessor :env
        attr_accessor :network
        attr_accessor :index

        DEFAULT = {
          'type' => nil,
          'ip' => '192.168.133.',
          'hostname' => 'invade.vm'
        }

        def initialize(env, network, index)
          @env = env
          @network = network
          @index = index
        end

        def validate
          return nil unless network

          # NETWORK TYPE
          @network['type'] = Validator.validate(
            @network['type'], 'type', 'string', DEFAULT['type']
          )

          # IP ADDRESS
          @network['ip'] = Validator.validate(
            @network['ip'], 'ip', 'string', "#{DEFAULT['ip']}#{7 + index if @index}"
          )

          # HOSTNAME
          @network['hostname'] = Validator.validate(
            @network['hostname'], 'hostname', 'string', "#{DEFAULT['hostname']}#{7 + index if @index}"
          )

          @network
        end
      end
    end
  end
end
