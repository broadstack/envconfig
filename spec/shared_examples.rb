shared_examples "empty configuration" do

  it "returns nil for keys" do
    [:url, :test].each do |k|
      expect(config[k]).to eq(nil)
    end
  end

  it "responds to #to_h with empty hash" do
    expect(config.to_h).to eq({})
  end

  it "has nil provider name" do
    expect(config.provider.name).to eq(nil)
  end

end

shared_examples "redis configuration" do |env_key|
  context "with openredis in ENV" do
    before do
      env[env_key] = "redis://:secrettoken@127.0.0.1:1234"
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
