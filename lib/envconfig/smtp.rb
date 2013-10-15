module Envconfig
  class Smtp

    include Service

    def self.providers
      [
        Custom,
        Mandrill,
        Postmark,
        Sendgrid,
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

    class Mandrill
      include Provider
      def mapping
        {
          username: "MANDRILL_USERNAME",
          password: "MANDRILL_APIKEY",
        }
      end
      def static
        {
          address: "smtp.mandrillapp.com",
          port: "25",
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

    class Sendgrid
      include Provider
      def mapping
        {
          username: "SENDGRID_USERNAME",
          password: "SENDGRID_PASSWORD",
        }
      end
      def static
        {
          address: "smtp.sendgrid.net",
          port: "587",
          authentication: :plain,
          enable_starttls_auto: true
        }
      end
    end

  end
end
