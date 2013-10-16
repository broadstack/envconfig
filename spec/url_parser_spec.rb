require "spec_helper"

module Envconfig
  describe UrlParser do

    let(:url) { "postgres://john:pass@a.example.org:1234/db?a=b&c=d" }
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

    describe "#extract_as" do
      it "returns hash with renamed keys" do
        result = parser.extract_as(
          adapter: ->(u){ u.scheme.sub(/\Apostgres\z/, "postgresql") },
          username: :user,
          port: :port,
        )
        expect(result).to eq(
          adapter: "postgresql",
          username: "john",
          port: 1234,
        )
      end
    end

    describe "#query_values" do
      it "returns query string as a hash with symbol keys" do
        expect(parser.query_values).to eq(
          a: "b",
          c: "d"
        )
      end
    end

  end
end
