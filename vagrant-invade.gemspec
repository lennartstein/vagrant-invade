# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-invade/version'

Gem::Specification.new do |s|
  s.name            = 'vagrant-invade'
  s.version         = Vagrant::Invade::VERSION
  s.authors         = ["Lennart Stein"]
  s.email           = 'frgmt@posteo.de'

  s.summary         = "A better configuration for Vagrant"
  s.description     = <<desc
Invade is a plugin to use Vagrant just with a single configuration file 'InvadeConfig'
instead using a complex 'Vagrantfile'. Invade will Vagrant's complexity for you
and finds the best options and solutions for your OS and System to successfully setup a Vagrant Box.
desc

  s.homepage        = 'https://github.com/frgmt/vagrant-invade'
  s.license         = 'MIT'
  s.date            = Time.now.strftime('%Y-%m-%d')

  s.files           = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.executables     = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.require_paths   = ['lib']

  s.add_development_dependency 'rails'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler', '<= 1.10.5, >= 1.5.2)'
end
