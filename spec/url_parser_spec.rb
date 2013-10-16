require "spec_helper"

module Envconfig
  describe UrlParser do

    let(:url) { "scheme://user:pass@a.example.org:1234" }
    subject(:parser) { UrlParser.new(url) }

    describe "#extract" do
      it "returns hash of requested keys" do
        expect(parser.extract(:password, :host, :port)).to eq(
          password: "pass",
          host: "a.example.org",
          port: 1234
        )
      end
    end

  end
end
