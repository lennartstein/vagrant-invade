# -*- mode: ruby -*-
# vi: set ft=ruby :

module Invade
  class Configuration < Base

    MODULE = 'CONFIG'

    def initialize
      if File.exist?('InvadeConfig')
        load 'InvadeConfig'
      else

        path = Dir.pwd

        # Try to get project dist first
        if File.exist?('../InvadeConfig.dist')
          FileUtils.cp('../InvadeConfig.dist', 'InvadeConfig')
          message = "InvadeConfig was not found. Copying template file \"../InvadeConfig.dist\"..."
          self.add_invade_text(MESSAGE_WARN, message)
          self.add_invade_text(MESSAGE_WARN, "Path: #{path}/InvadeConfig")
          self.add_invade_text(MESSAGE_OK, 'Restarting InVaDE with copied config file...')
          self.invade_text
          sleep(3)
          exec('vagrant up')
        else # Project dist not found. Use InVaDE basic template instead
          FileUtils.cp('InvadeConfig.dist', 'InvadeConfig')
          message = "InvadeConfig was not found. Config created from template file \"InvadeConfig.dist\". Please edit!"
          self.add_invade_text(MESSAGE_EXIT, message)
          self.add_invade_text(MESSAGE_EXIT, "\nPath: #{path}/InvadeConfig")
        end
      end

      self.invade_text
    end
  end
end
