# vagrant-invade

![Invade Logo](https://github.com/frgmt/vagrant-invade/blob/develop/images/invade-logo-256.png?raw=true)

[![Code Climate](https://codeclimate.com/github/frgmt/vagrant-invade/badges/gpa.svg)](https://codeclimate.com/github/frgmt/vagrant-invade)

**vagrant-invade** is a plugin for Vagrant, the tool for creating and maintain virtual machines.  
It uses a simple **YAML** configuration file to automatically build a **Vagrantfile** for your projects.

## How to install
Simply run `vagrant plugin install vagrant-invade`  
To install a certain version use the `-v 'VERSION'` option.

## Commands
There are new commands you can use to init, validate and build your Vagrantfile.

### Init
`vagrant invade init` creates the default **invade.yml** configuration file for you.

### Validate
`vagrant invade validate` will validate the **invade.yml** file and gives you a **detailed output of missing values, wrong parameters and defaults** for each option.

### Build
`vagrant invade build` will **build a Vagrantfile** based on what you set in the 'invade.yml' configuration file and place it to the directory you did run the command.

## Development
You are able to collaborate to make this plugin even better. You just need a simple setup of ruby software to make it work. You could also use RVM to keep your ruby environment clean.

### Requirements
1. Vagrant v1.7+
2. Ruby >= 2.0.0
3. RubyGems
4. Bundler

### Setup
1. ``gem install bundler``
2. ``bundle install``
