module Envconfig
  module Service

    def initialize(env)
      @env = env
    end

    # The configuration for the service, as a Hash.
    def to_h
      config
    end

    # A single key from the configuration.
    def [](key)
      config[key]
    end

    private

    attr_reader :env

    def config
      @_config ||= provider.config
    end

    def provider
      ProviderResolver.new(env, self.class.providers).provider
    end

  end
end
