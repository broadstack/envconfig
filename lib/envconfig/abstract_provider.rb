module Envconfig

  # An abstract (partial) provider implementation which, given
  # a mapping of config keys to environment variable names,
  # can determine whether the environment is valid and derive a config.
  class AbstractProvider

    def initialize(env)
      @env = env
    end

    # Whether the environment is valid for this provider.
    def valid?
      mapping.values.all? { |env_key| env.key?(env_key) }
    end

    # The configuration derived from the environment for this provider.
    def config
      mapping.inject({}) do |result, (result_key, env_key)|
        result[result_key] = env[env_key]
        result
      end
    end

    private

    attr_reader :env

    # A mapping of configuration keys to environment keys.
    # e.g.
    # {
    #   address: "PROVIDER_HOSTNAME",
    #   password: "PROVIDER_API_KEY",
    # }
    def mapping
      raise "Mapping must be implemented by subclass."
    end

  end

end
