require "spec_helper"

describe "redis configuration" do

  let(:env) { {} }
  subject(:config) { Envconfig.load(env).redis }

  context "with nothing relevant in ENV" do
    it_behaves_like "empty configuration"
  end

  %w{
    OPENREDIS_URL
    REDISCLOUD_URL
    REDISGREEN_URL
  }.each do |env_key|
    it_behaves_like "redis configuration", env_key
  end

end
