require "spec_helper"

module Envconfig
  describe UrlParser do

    let(:url) { "mysql://john:pass@a.example.org:1234" }
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
          adapter: :scheme,
          username: :user,
          port: :port,
        )
        expect(result).to eq(
          adapter: "mysql",
          username: "john",
          port: 1234,
        )
      end
    end

  end
end
