module Envconfig

  # Given an ENV and a list of provider classes, returns an instance
  # of the first provider class that considers the ENV valid.
  class ProviderResolver

    def initialize(env, providers)
      @env = env
      @providers = providers
    end

    def provider
      provider_or_nil || NullProvider.new
    end

    private

    attr_reader :env
    attr_reader :providers

    def provider_or_nil
      # I'd use Enumerator#lazy but for Ruby 1.9 support.
      providers.map { |k| k.new(env) }.detect(&:valid?)
    end

    class NullProvider
      def config; {} end
    end

  end
end
