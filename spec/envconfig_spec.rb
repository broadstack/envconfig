require "spec_helper"

describe Envconfig do

  it "loads from an ENV-like hash" do
    result = Envconfig.load({"KEY" => "value"})
    expect(result.class).to eq(Envconfig::Root)
  end

  # I don't want to modify or make assumptions about ENV,
  # but at least test that Envconfig.load() handles zero arguments.
  it "loads without an argument (defaulting to ENV)" do
    result = Envconfig.load()
    expect(result.class).to eq(Envconfig::Root)
  end

end
