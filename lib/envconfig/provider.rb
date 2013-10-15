module Envconfig
  module Provider

    def self.find(env, providers)
      providers.map { |k| k.new(env) }.detect(&:valid?) ||
        NullProvider.new
    end

    def initialize(env)
      @env = env
    end

    # A mapping of configuration keys to environment keys.
    # e.g.
    # {
    #   address: "PROVIDER_HOSTNAME",
    #   password: "PROVIDER_API_KEY",
    # }
    def mapping
      raise "Mapping must be implemented by subclass."
    end

    # Static configuration which doesn't vary by environment.
    # e.g. hostname / port.
    def static
      {}
    end

    def name
      self.class.name.split("::").last
    end

    # Whether the environment is valid for this provider.
    def valid?
      env_keys.all? { |k| env.key?(k) }
    end

    # Which ENV keys are used by this provider.
    def env_keys
      mapping.values
    end

    # The configuration derived from the environment for this provider.
    def config
      static.merge(dynamic)
    end

    private

    attr_reader :env

    def dynamic
      mapping.inject({}) do |result, (result_key, env_key)|
        result[result_key] = env[env_key] if env.key?(env_key)
        result
      end
    end

    class NullProvider
      def config; {} end
      def name; nil; end
    end

  end
end
