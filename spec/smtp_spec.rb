require "spec_helper"

describe "SMTP configuration" do

  let(:env) { {} }
  subject(:config) { Envconfig.from(env).smtp }

  context "with nothing relevant in ENV" do
    it "returns nil for keys" do
      %i{address port user_name password}.each do |k|
        expect(config[k]).to eq(nil)
      end
    end
    it "responds to #to_h with empty hash" do
      expect(config.to_h).to eq({})
    end
  end

  context "with Mandrill in ENV" do
    before {
      env["MANDRILL_USERNAME"] = "mandrilluser"
      env["MANDRILL_APIKEY"] = "mandrillkey"
    }
    it "sets address, port, user_name, password" do
      expect(config.to_h).to eq(
        address: "smtp.mandrillapp.com",
        port: "25",
        user_name: "mandrilluser",
        password: "mandrillkey",
      )
    end
  end

  context "with Postmark in ENV" do
    before {
      env["POSTMARK_SMTP_SERVER"] = "postmark.example.org"
      env["POSTMARK_API_KEY"] = "b6ebafbec9a31661f6247f21ff4a68d9"
    }
    it "sets address, user_name, password" do
      expect(config.to_h).to eq(
        address: "postmark.example.org",
        user_name: "b6ebafbec9a31661f6247f21ff4a68d9",
        password: "b6ebafbec9a31661f6247f21ff4a68d9",
        port: "25",
        authentication: :plain,
      )
    end
  end

  context "with SendGrid in ENV" do
    before {
      env["SENDGRID_USERNAME"] = "sendgriduser"
      env["SENDGRID_PASSWORD"] = "sendgridpassword"
    }
    it "sets address, user_name, password" do
      expect(config.to_h).to eq(
        user_name: "sendgriduser",
        password: "sendgridpassword",
        address: "smtp.sendgrid.net",
        port: "587",
        authentication: :plain,
        enable_starttls_auto: true
      )
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
        user_name: nil,
        password: nil,
      )
    end
  end

end
