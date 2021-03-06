require "spec_helper"

describe "SMTP configuration" do

  let(:env) { {} }
  subject(:config) { Envconfig.load(env).smtp }

  context "with nothing relevant in ENV" do
    it_behaves_like "empty configuration"
  end

  context "with Mailgun in ENV" do
    before do
      env['MAILGUN_SMTP_PORT'] = 2468
      env['MAILGUN_SMTP_SERVER'] = "mailgun.example.org"
      env['MAILGUN_SMTP_LOGIN'] = "mailgunuser"
      env['MAILGUN_SMTP_PASSWORD'] = "a493216c9ced751d6bc38fd6f5c3930b"
    end
    it "identifies as Mailgun" do
      expect(config.provider.name).to eq("Mailgun")
    end
    it "sets port, address, user_name, password" do
      expect(config.to_h).to eq(
        address: "mailgun.example.org",
        port: 2468,
        user_name: "mailgunuser",
        password: "a493216c9ced751d6bc38fd6f5c3930b",
      )
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
        port: "587",
        user_name: "mandrilluser",
        password: "mandrillkey",
      )
    end
    it "identifies as Mandrill" do
      expect(config.provider.name).to eq("Mandrill")
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
    it "identifies as Postmark" do
      expect(config.provider.name).to eq("Postmark")
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
    it "identifies as SendGrid" do
      expect(config.provider.name).to eq("SendGrid")
    end
  end

  context "with only SMTP_PORT=2525 in env" do
    before { env["SMTP_PORT"] = "2525" }
    it "has port 2525" do
      expect(config[:port]).to eq("2525")
    end
    it "only has port 2525" do
      expect(config.to_h).to eq(
        port: "2525",
      )
    end
  end

end
