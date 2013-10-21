require "spec_helper"

describe "MongoDB configuration" do

  let(:env) { {} }
  let(:config) { Envconfig.load(env).mongodb }

  context "with nothing relevant in ENV" do
    it_behaves_like "empty configuration"
  end

  %w{
    MONGOHQ_URL
    MONGOLAB_URI
  }.each do |env_key|
    it_behaves_like "mongodb configuration", env_key
  end

end
