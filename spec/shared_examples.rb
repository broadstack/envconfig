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
