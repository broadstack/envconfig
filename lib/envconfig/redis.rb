require "uri"

module Envconfig
  class Redis

    include Service

    def self.providers
      [
        Openredis,
        Redisgreen,
      ]
    end

    module ConfigFilter
      def filter_config(config)
        url = UrlParser.new(config[:url])
        config.merge!(url.extract(:host, :port, :user, :password))
      end
    end

    class Openredis
      include Provider
      include ConfigFilter
      def name; "openredis" end
      def mapping
        {url: "OPENREDIS_URL"}
      end
    end

    class Redisgreen
      include Provider
      include ConfigFilter
      def name; "RedisGreen" end
      def mapping
        {url: "REDISGREEN_URL"}
      end
    end

  end
end
