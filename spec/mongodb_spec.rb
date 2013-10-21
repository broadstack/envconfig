require "spec_helper"

describe "MongoDB configuration" do

  mongo_url = "mongodb://user:pass@example.org:5432/db?a=b&c=d"

  let(:env) { {} }
  let(:config) { Envconfig.load(env).mongodb }

  context "with nothing relevant in ENV" do
    it_behaves_like "empty configuration"
  end

end
