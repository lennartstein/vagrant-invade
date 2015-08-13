module VagrantPlugins
  module Invade
    class Config < Vagrant.plugin('2', :config)

      attr_accessor :invade
      attr_accessor :enabled
      attr_accessor :manage_host
      attr_accessor :ignore_private_ip
      attr_accessor :aliases
      attr_accessor :include_offline
      attr_accessor :ip_resolver

      alias_method :enabled?, :enabled
      alias_method :include_offline?, :include_offline
      alias_method :manage_host?, :manage_host

      def initialize
        @logger             = Log4r::Logger.new('vagrant::invade::config')
        @invade             = VagrantPlugins::Invade.get_invade_config

        # Invade
        @enabled            = UNSET_VALUE
        @terminal_color     = UNSET_VALUE

        # Box
        @manage_host        = UNSET_VALUE
        @ignore_private_ip  = UNSET_VALUE
        @include_offline    = UNSET_VALUE
        @aliases            = UNSET_VALUE
        @ip_resolver        = UNSET_VALUE
      end

      def finalize!
        @enabled            = false if @enabled == UNSET_VALUE
        @manage_host        = false if @manage_host == UNSET_VALUE
        @ignore_private_ip  = false if @ignore_private_ip == UNSET_VALUE
        @include_offline    = false if @include_offline == UNSET_VALUE
        @aliases            = [] if @aliases == UNSET_VALUE
        @ip_resolver        = nil if @ip_resolver == UNSET_VALUE

        @aliases = [ @aliases ].flatten
      end
    end
  end
end
