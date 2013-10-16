require "uri"

module Envconfig
  class UrlParser

    def initialize(url)
      @url = url
    end

    # Extract the given keys verbatim from the URL.
    # These map to public instance methods on URI.
    def extract(*keys)
      keys.inject({}) do |hash, key|
        hash.merge!(key => parsed_url.public_send(key))
      end
    end

    # Extract and rename the given keys.
    # The mapping keys are the wanted keys, the mapping values
    # are public instance methods on URI.
    def extract_as(mapping)
      mapping.inject({}) do |hash, (key, method)|
        hash.merge!(key => extract_value(method))
      end
    end

    private

    def parsed_url
      @_parsed_url ||= URI.parse(@url)
    end

    def extract_value(method)
      if method.respond_to?(:call)
        method.call(parsed_url)
      else
        parsed_url.public_send(method)
      end
    end

  end
end
