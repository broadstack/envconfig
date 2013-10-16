require "uri"

module Envconfig
  class Redis

    include Service

    def self.providers
      [
        Openredis,
      ]
    end

    class Openredis
      include Provider
      def name; "openredis" end
      def mapping
        {url: "OPENREDIS_URL"}
      end
      def filter_config(config)
        config.merge!(
          parts_from_url(config[:url])
        )
      end

      def parts_from_url(url)
        url = URI.parse(url)
        {
          host: url.host,
          port: url.port,
          user: url.user,
          password: url.password,
        }
      end
    end

  end
end
