require "spec_helper"

describe Envconfig::Root do

  let(:env) { {} }
  subject(:root) { Envconfig::Root.new(env) }

  context "with nothing in ENV" do

    describe "#smtp?" do
      it "is false" do
        expect(root.smtp?).to eq(false)
      end
    end

    describe "#smtp" do
      [:to_h, :provider, :[]].each do |m|
        it "responds to :#{m}" do
          expect(root.smtp.respond_to?(m)).to eq(true)
        end
      end
      it "has an empty #to_h result" do
        expect(root.smtp.to_h).to eq({})
      end
    end

  end

end
