module Envconfig
  class Smtp

    include Service

    def self.providers
      [
        Custom,
        Postmark,
      ]
    end

    # A custom configuration, for local or self-managed SMTP servers.
    class Custom
      include Provider
      def valid?
        mapping.values.any? { |k| env.key?(k) } #any? instead of #all?
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

    class Postmark
      include Provider
      def mapping
        {
          address: "POSTMARK_SMTP_SERVER",
          username: "POSTMARK_API_KEY",
          password: "POSTMARK_API_KEY",
        }
      end
      def static
        {
          port: "25",
          authentication: :plain,
        }
      end
    end

  end
end
