require "spec_helper"

describe "memcached configuration" do

  let(:env) { {} }
  subject(:config) { Envconfig.load(env).memcached }

  context "with nothing relevant in ENV" do
    it_behaves_like "empty configuration"
  end

  context "with MemCachier in ENV" do
    before do
      env["MEMCACHIER_SERVERS"] = "m1.example.org:11211,m2.example.org:11211"
      env["MEMCACHIER_USERNAME"] = "memcachieruser"
      env["MEMCACHIER_PASSWORD"] = "memcachierpass"
    end

    {
      servers: "m1.example.org:11211,m2.example.org:11211",
      username: "memcachieruser",
      password: "memcachierpass",
      server_strings: ["m1.example.org:11211", "m2.example.org:11211"],
    }.each do |key, value|
      it "sets :#{key} to #{value.inspect}" do
        expect(config[key]).to eq(value)
      end
    end
  end

end
