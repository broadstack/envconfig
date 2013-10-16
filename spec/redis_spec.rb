require "spec_helper"

describe "redis configuration" do

  let(:env) { {} }
  subject(:config) { Envconfig.load(env).redis }

  context "with nothing relevant in ENV" do
    it_behaves_like "empty configuration"
  end

  context "with openredis in ENV" do
    before do
      env["OPENREDIS_URL"] = "redis://:secrettoken@127.0.0.1:1234"
    end

    {
      url: "redis://:secrettoken@127.0.0.1:1234",
      host: "127.0.0.1",
      port: 1234,
      user: "",
      password: "secrettoken",
    }.each do |key, value|
      it "sets :#{key} to #{value.inspect}" do
        expect(config[key]).to eq(value)
      end
    end
  end
end
