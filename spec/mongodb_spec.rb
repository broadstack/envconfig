require "spec_helper"

describe "MongoDB configuration" do

  mongo_url = "mongodb://user:pass@example.org:2468/db?a=b&c=d"

  let(:env) { {} }
  let(:config) { Envconfig.load(env).mongodb }

  context "with nothing relevant in ENV" do
    it_behaves_like "empty configuration"
  end

  context "with MONGOHQ_URL='#{mongo_url}' in ENV" do
    before do
      env["MONGOHQ_URL"] = mongo_url
    end

    {
      url: mongo_url,
      database: "db",
      username: "user",
      password: "pass",
      host: "example.org",
      port: 2468,
      a: "b",
      c: "d",
    }.each do |key, value|
      it "sets :#{key} to #{value.inspect}" do
        expect(config[key]).to eq(value)
      end
    end
  end

end
