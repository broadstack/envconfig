require "spec_helper"

describe "memcached configuration" do

  let(:env) { {} }
  subject(:config) { Envconfig.load(env).memcached }

  context "with nothing relevant in ENV" do
    it_behaves_like "empty configuration"
  end

end
