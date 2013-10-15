module Envconfig
  class Smtp

    def self.providers
      [
        Custom,
        Postmark,
      ]
    end

    def initialize(env)
      @env = env
    end

    def to_h
      config
    end

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

    # A custom configuration, for local or self-managed SMTP servers.
    class Custom < AbstractProvider
      def valid?
        # Use #any? instead of #all? for this provider.
        mapping.values.any? { |k| env.key?(k) }
      end
      def mapping
        {
          address: "SMTP_HOST",
          port: "SMTP_PORT",
          username: "SMTP_USERNAME",
          password: "SMTP_PASSWORD",
        }
      end
    end

    class Postmark < AbstractProvider
      def mapping
        {
          address: "POSTMARK_SMTP_SERVER",
          username: "POSTMARK_API_KEY",
          password: "POSTMARK_API_KEY",
        }
      end
    end

  end
end
