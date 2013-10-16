module Envconfig
  class Database

    include Service

    def self.providers
      [
        Generic,
      ]
    end

    class Generic
      include Provider
      def mapping
        {url: "DATABASE_URL"}
      end
      def filter_config(config)
        url = UrlParser.new(config[:url])
        parts = url.extract_as(
          adapter: ->(u){ (u.scheme || "").sub(/\Apostgres\z/, "postgresql") },
          database: ->(u){ (u.path || "").split("/")[1] },
          username: :user,
          password: :password,
          host: :host,
          port: :port,
        )
        config.merge!(parts).merge!(url.query_values)
      end
    end

  end
end
