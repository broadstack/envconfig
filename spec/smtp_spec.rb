require "spec_helper"

describe "SMTP configuration" do

  let(:env) { {} }
  let(:config) { Envconfig.from(env).smtp }

  context "with nothing relevant in ENV" do
    pending
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

end
