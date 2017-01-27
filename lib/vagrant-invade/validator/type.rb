module VagrantPlugins
  module Invade
    module Validator
      module Type
        autoload :ArrayValidator, 'vagrant-invade/validator/type/type_array'
        autoload :BooleanValidator, 'vagrant-invade/validator/type/type_boolean'
        autoload :HashValidator, 'vagrant-invade/validator/type/type_hash'
        autoload :IntegerValidator, 'vagrant-invade/validator/type/type_integer'
        autoload :StringOrArrayValidator, 'vagrant-invade/validator/type/type_string_array'
        autoload :StringValidator, 'vagrant-invade/validator/type/type_string'
        autoload :SymbolValidator, 'vagrant-invade/validator/type/type_symbol'
      end
    end
  end
end
