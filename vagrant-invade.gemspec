# coding: utf-8
require File.expand_path('../lib/vagrant-invade/version', __FILE__)

Gem::Specification.new do |s|
  s.name            = 'vagrant-invade'
  s.version         = VagrantPlugins::Invade::VERSION
  s.date            = '2015-08-10'
  s.summary         = "Create a Vagrantfile with a single YAML configuration file"
  s.description     = "InVaDE is a plugin that uses a YAML configuration file to build a Vagrantfile from it."
  s.authors         = ["Lennart Stein"]
  s.email           = 'frgmt@posteo.de'
  s.files           = `git ls-files`.split($\)
  s.executables     = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.require_paths   = ['lib']
  s.homepage        = 'https://github.com/frgmt/vagrant-invade'
  s.license         = 'GNU'
end
