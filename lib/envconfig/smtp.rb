module Envconfig
  class Smtp

    def self.providers
      [
        Postmark,
      ]
    end

    def initialize(env)
      @env = env
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

    class Postmark < AbstractProvider
      private
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
