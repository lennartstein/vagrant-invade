require 'bundler'

begin
    require 'vagrant'
rescue LoadError
    Bundler.require(:default, :development)
end

require 'vagrant-invade/plugin'
require 'vagrant-invade/command'
