module Envconfig
  class Mongodb

    include Service

    def self.providers
      [
        Mongohq,
      ]
    end

    class Mongohq
      include Provider
      def mapping
        {url: "MONGOHQ_URL"}
      end
      def filter_config(config)
        url = UrlParser.new(config[:url])
        parts = url.extract_as(
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
