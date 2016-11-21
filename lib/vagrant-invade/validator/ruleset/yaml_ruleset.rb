module VagrantPlugins
  module Invade
    module Validator
      module Ruleset

        class YAMLRuleset

          attr_accessor :rules, :depth, :module_name

          def initialize(env)
            @ui           = env[:ui]
            @quite        = env[:invade_validate_quiet]

            @part_name    = nil
            @type_name    = nil

            @module_name  = nil

            @rules        = nil
            @ruleset_file = nil

            @depth        = 0
            @logger       = Log4r::Logger.new('vagrant::invade::validator::ruleset')
          end

          def build(part_name, type_name)

            @part_name = part_name
            @type_name = type_name

            # Set module name string
            if @depth > 1
              @module_name = "#{part_name}/#{type_name}"
            else
              @module_name = type_name
            end

            # Set module path
            @ruleset_file = "#{RULESET_ROOT_DIR}/#{@module_name}/rules.yml"

            if ruleset_file_exist?
              begin
                @rules = YAML.load_file(@ruleset_file)
                @ui.success("\tBuild rules with ruleset file.") unless @quite
              rescue IOError => e
                @logger.error e
                fail e
              end
            else

              @ui.warn("\tWarning: Ruleset file of module '#{@module_name}' could not be found.\n\tSKIP VALIDATION")

              # Set rules to nil if ruleset were not found
              @rules = nil
            end
          end

          def valid?(option_name)
            if @rules.nil?
              raise 'Rules not yet build. Ruleset needs to build rules first. Running f|valid? before f|build?'
            else

              # If rule of option does not exist return false
              unless @rules[option_name]
                @ui.warn("\t#{option_name} => doesn't exist in ruleset of module #{@module_name}. - SKIP")

                return false
              end

              @rules.each do |option_key, option_value|
                option_value.each do |option_type_key, _|
                  unless valid_option?(option_type_key)
                    @ui.warn("\tWarning: Ruleset of module '#{@module_name}'\n\tRule '#{option_type_key}' defined for option '#{option_key}' is not a valid rule.\n\tSKIP VALIDATION.")

                    return false
                  end
                end
              end

            end
          end

          private

          def ruleset_file_exist?
            (File.exist?(@ruleset_file) && !File.zero?(@ruleset_file))
          end

          def valid_option?(option)
            RULESET_OPTION_KEYS.include?(option)
          end

        end
      end
    end
  end
end
