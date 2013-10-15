require "spec_helper"

module Envconfig
  describe "finding a provider" do

    let(:env) { {} }
    let(:providers) { [] }

    subject(:provider) do
      Provider.find(env, providers)
    end

    context "with assorted providers" do
      class InvalidProvider
        def initialize(env); end
        def valid?; false end
      end
      class ValidProvider < InvalidProvider
        def valid?; true; end
        def config; {key: "value"}; end
      end
      class ValidProviderB < ValidProvider
      end

      let(:providers) do
        [InvalidProvider, ValidProvider, ValidProviderB]
      end

      it "resolves to an instance of ValidProvider" do
        expect(provider.class).to eq(ValidProvider)
      end

      it "provides ValidProvider's config" do
        expect(provider.config).to eq(key: "value")
      end

    end

    context "when no providers are valid" do
      it "resolves to a null-provider with empty config" do
        expect(provider.config).to eq({})
      end
    end

  end
end
