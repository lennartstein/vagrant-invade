require 'bundler'

begin
  require 'vagrant'
rescue LoadError
  Bundler.require(:default, :development)
end

require 'vagrant-invade/config'
require 'vagrant-invade/plugin'
require 'vagrant-invade/command'

module VagrantPlugins
  module Invade

    public

    def self.source_root
      @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end
  end
end
