require "uri"

module Envconfig
  class UrlParser

    def initialize(url)
      @url = url
    end

    def extract(*keys)
      keys.inject({}) do |hash, key|
        hash.merge!(key => parsed_url.public_send(key))
      end
    end

    private

    def parsed_url
      @_parsed_url ||= URI.parse(@url)
    end

  end
end
