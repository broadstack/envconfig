require "spec_helper"

describe "database configuration" do

  let(:env) { {} }
  let(:config) { Envconfig.load(env).database }

  context "with nothing relevant in ENV" do
    it_behaves_like "empty configuration"
  end

end
