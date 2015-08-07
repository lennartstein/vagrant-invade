module Vagrant

    module Invade
        class Plugin < Vagrant.plugin('2')
            name "Invade"

            description <<-DESC
            This plugin configures Vagrant for you
            DESC

            command 'invade' do
                require_relative 'command'
                Command
            end
        end
    end

end
