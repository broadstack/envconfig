module Envconfig
  class Memcached

    include Service

    def self.providers
      [
        Memcachier,
      ]
    end

    class Memcachier
      include Provider
      def name; "MemCachier" end
      def mapping
        {
          servers: "MEMCACHIER_SERVERS",
          username: "MEMCACHIER_USERNAME",
          password: "MEMCACHIER_PASSWORD",
        }
      end
      def filter_config(hash)
        hash.merge!(
          server_strings: hash[:servers].split(",")
        )
      end
    end

  end
end
