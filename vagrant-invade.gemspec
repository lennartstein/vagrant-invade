# coding: utf-8
require File.expand_path('../lib/vagrant-invade/version', __FILE__)

Gem::Specification.new do |s|
  s.name            = 'vagrant-invade'
  s.version         = Vagrant::Invade::VERSION
  s.date            = '2015-08-10'
  s.summary         = "List all vms"
  s.description     = "A simple vagrant plugin for listing all vms"
  s.authors         = ["Lennart Stein"]
  s.email           = 'frgmt@posteo.de'
  s.files           = `git ls-files`.split($\)
  s.executables     = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.require_paths   = ['lib']
  s.homepage        = 'https://github.com/frgmt/vagrant-invade'
  s.license         = 'GNU'
end
