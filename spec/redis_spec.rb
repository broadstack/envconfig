require "spec_helper"

describe "redis configuration" do

  let(:env) { {} }
  subject(:config) { Envconfig.load(env).redis }

  context "with nothing relevant in ENV" do
    it_behaves_like "empty configuration"
  end

end
