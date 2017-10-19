require "test_helper"

describe Merchant do
  let(:merchant_one) { merchants(:first_merchant) }
  let(:merchant_two) { merchants(:second_merchant) }

  describe "valid" do
    it "will return false without a username" do
      merchant_one.username = nil
      merchant_one.wont_be :valid?
    end

    it "will return false with a non unique username" do
      merchant_two.username = merchant_one.username
      merchant_two.wont_be :valid?
    end

    it "will return false without an email" do
      merchant_one.username = nil
      merchant_one.wont_be :valid?
    end

    it "Will return false with a non unique email" do
      merchant_one.email = merchant_two.email
      merchant_one.wont_be :valid?
    end
  end

  describe "#products" do
    it "should return a collection of products" do
      merchant_one.must_respond_to :products
      merchant_one.products.must_be_kind_of Enumerable
      merchant_one.products.each do |product|
        product.must_be_kind_of Product
      end
    end

    it "Will respond to product" do
      merchant_one.products.must_include products(:first_product)
    end

    it "will return an empty array when a merchant has no products" do
      m = Merchant.new
      m.products.must_equal []
    end
  end
end
