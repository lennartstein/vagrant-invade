module VagrantPlugins
  module Invade
    module Validator
      module Ruleset
        autoload :YAMLRuleset, 'vagrant-invade/validator/ruleset/yaml_ruleset'

        RULESET_ROOT_DIR    = File.join(File.dirname(__FILE__), '../module')
        RULESET_OPTION_KEYS = %w(type default)
      end
    end
  end
end
