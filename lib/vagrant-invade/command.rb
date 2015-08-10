module Vagrant

    module Invade
        class Command < Vagrant.plugin('2', :command)
            # Show description when `vagrant list-commands` is triggered
            def self.synopsis
            "plugin: vagrant-hostmanager: manages the /etc/hosts file within a multi-machine environment"
            end

            def execute
                exec('VBoxManage list vms')
                0
            end
        end
    end

end
