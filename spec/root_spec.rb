require "spec_helper"

describe Envconfig::Root do

  let(:env) { {} }
  subject(:root) { Envconfig::Root.new(env) }

  context "with nothing in ENV" do

    service_methods = [
      :database,
      :memcached,
      :redis,
      :smtp,
    ]

    service_methods.each do |service_method|
      predicate_method = :"#{service_method}?"

      describe "##{predicate_method}" do
        it "is false" do
          expect(root.public_send(predicate_method)).to eq(false)
        end
      end

      describe "##{service_method}" do
        [:to_h, :provider, :[]].each do |m|
          it "claims to respond to :#{m}" do
            expect(root.smtp.respond_to?(m)).to eq(true)
          end
        end
        it "has an empty #to_h result" do
          expect(root.smtp.to_h).to eq({})
        end
        it "responds to #provider with an object with no name" do
          expect(root.smtp.provider.name).to eq(nil)
        end
      end
    end

    describe "#to_h" do
      it "returns a nested hash of all configuration" do
        expect(root.to_h).to eq(
          database: {},
          memcached: {},
          redis: {},
          smtp: {},
        )
      end
    end

  end

  context "with all of the things in ENV" do
    let(:env) do
      # Note: actual precedence is defined in the service classes,
      # generally based on alphabetical sorting.
      # This example ENV intentionally mixes up the precedence ordering.
      # e.g. the Redis services match their actual precedence,
      # but the SMTP services reverse their actual precedence.
      {
        "DATABASE_URL" => "postgres://u:p@db.example.org:1234/db",
        "MEMCACHIER_SERVERS" => "mc.example.org:11211",
        "MEMCACHIER_USERNAME" => "mcuser",
        "MEMCACHIER_PASSWORD" => "mcpass",
        "OPENREDIS_URL" => "redis://:orpass@or.example.org:2345",
        "REDISTOGO_URL" => "redis://:rtgpass@rtg.example.org:3456",
        "SENDGRID_USERNAME" => "sguser",
        "SENDGRID_PASSWORD" => "sgpass",
        "POSTMARK_SMTP_SERVER" => "pm.example.org",
        "POSTMARK_API_KEY" => "pmkey",
      }
    end
    it "has a giant #to_h" do
      expect(root.to_h).to eq(
        database: {
          url: "postgres://u:p@db.example.org:1234/db",
          adapter: "postgresql",
          database: "db",
          username: "u",
          password: "p",
          host: "db.example.org",
          port: 1234
        },
        memcached: {
          servers: "mc.example.org:11211",
          username: "mcuser",
          password: "mcpass",
          server_strings: ["mc.example.org:11211"]
        },
        redis: {
          url: "redis://:orpass@or.example.org:2345",
          host: "or.example.org",
          port: 2345,
          user: "",
          password: "orpass"
        },
        smtp: {
          port: "25",
          authentication: :plain,
          address: "pm.example.org",
          user_name: "pmkey",
          password: "pmkey"
        }
      )
    end
  end

end
