require "spec_helper"

describe "SMTP configuration" do

  let(:env) { {} }
  subject(:config) { Envconfig.from(env).smtp }

  context "with nothing relevant in ENV" do
    it "returns nil for keys" do
      %i{address port username password}.each do |k|
        expect(config[k]).to eq(nil)
      end
    end
    it "responds to #to_h with empty hash" do
      expect(config.to_h).to eq({})
    end
  end

  context "with Postmark in ENV" do
    before {
      env["POSTMARK_SMTP_SERVER"] = "postmark.example.org"
      env["POSTMARK_API_KEY"] = "b6ebafbec9a31661f6247f21ff4a68d9"
    }
    it "has correct address" do
      expect(config[:address]).to eq("postmark.example.org")
    end
    it "has correct username" do
      expect(config[:username]).to eq("b6ebafbec9a31661f6247f21ff4a68d9")
    end
    it "has correct password" do
      expect(config[:password]).to eq("b6ebafbec9a31661f6247f21ff4a68d9")
    end
  end

  context "with only SMTP_PORT=2525 in env" do
    before { env["SMTP_PORT"] = "2525" }
    it "has port 2525" do
      expect(config[:port]).to eq("2525")
    end
    it "has nil for other values" do
      expect(config.to_h).to eq(
        address: nil,
        port: "2525",
        username: nil,
        password: nil,
      )
    end
  end

end
