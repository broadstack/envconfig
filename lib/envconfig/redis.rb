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
        url = UrlParser.new(config[:url])
        config.merge!(url.extract(:host, :port, :user, :password))
      end
    end

  end
end
