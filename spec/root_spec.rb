require "spec_helper"

describe Envconfig::Root do

  let(:env) { {} }
  subject(:root) { Envconfig::Root.new(env) }

  context "with nothing in ENV" do

    service_methods = [
      :smtp,
    ]

    service_methods.each do |service_method|
      predicate_method = :"#{service_method}?"

      describe "##{predicate_method}" do
        it "is false" do
          expect(root.public_send(predicate_method)).to eq(false)
        end
      end

      describe "##{service_method}" do
        [:to_h, :provider, :[]].each do |m|
          it "claims to respond to :#{m}" do
            expect(root.smtp.respond_to?(m)).to eq(true)
          end
        end
        it "has an empty #to_h result" do
          expect(root.smtp.to_h).to eq({})
        end
        it "responds to #provider with an object with no name" do
          expect(root.smtp.provider.name).to eq(nil)
        end
      end
    end

  end

end
