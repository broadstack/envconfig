require "spec_helper"

describe "database configuration" do

  database_url = "postgres://user:pass@example.org:5432/db?a=b&c=d"

  let(:env) { {} }
  let(:config) { Envconfig.load(env).database }

  context "with nothing relevant in ENV" do
    it_behaves_like "empty configuration"
  end

  context "with DATABASE_URL='#{database_url}' in ENV" do
    before do
      env["DATABASE_URL"] = database_url
    end

    {
      url: database_url,
      adapter: "postgresql", # transformed like heroku-buildpack-ruby
      database: "db",
      username: "user",
      password: "pass",
      host: "example.org",
      port: 5432,
      a: "b",
      c: "d",
    }.each do |key, value|
      it "sets :#{key} to #{value.inspect}" do
        expect(config[key]).to eq(value)
      end
    end
  end

end
