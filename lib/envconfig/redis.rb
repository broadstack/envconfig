require "uri"

module Envconfig
  class Redis

    include Service

    def self.providers
      [
        Openredis,
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

  end
end
