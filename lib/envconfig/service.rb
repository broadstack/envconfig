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

    def provider
      @_provider ||= Provider.find(env, self.class.providers)
    end

    private

    attr_reader :env

    def config
      @_config ||= provider.config
    end

  end
end
