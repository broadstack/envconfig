require "uri"

module Envconfig
  class Redis

    include Service

    def self.providers
      [
        Generic,
        Openredis,
        Rediscloud,
        Redisgreen,
        Redistogo,
      ]
    end

    module ConfigFilter
      def filter_config(config)
        url = UrlParser.new(config[:url])
        config.merge!(url.extract(:host, :port, :user, :password))
      end
    end

    class Generic
      include Provider
      include ConfigFilter
      def name; "genericredis" end
      def mapping
        {url: "REDIS_URL"}
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

    class Rediscloud
      include Provider
      include ConfigFilter
      def name; "Redis Cloud" end
      def mapping
        {url: "REDISCLOUD_URL"}
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

    class Redistogo
      include Provider
      include ConfigFilter
      def name; "Redis To Go" end
      def mapping
        {url: "REDISTOGO_URL"}
      end
    end

  end
end
