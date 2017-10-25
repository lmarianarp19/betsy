require "test_helper"

describe Merchant do
  let(:merchant_one) { merchants(:first_merchant) }
  let(:merchant_two) { merchants(:second_merchant) }
  let(:merchant_new) {Merchant.new}

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

  describe "relationships" do
    it "has a list of products" do
      merchant_one.must_respond_to :products
      merchant_one.products.must_be_kind_of Enumerable
      merchant_one.products.each do |product|
        product.must_be_kind_of Product
      end
    end
    it "has a list of order_items" do
      merchant_new.orders.must_equal []
    end
    it "has a list of orders" do

    end
  end

  describe "Custom methods" do
    describe "distinct_orders" do
      it "will return an array of orders for a merchant that has orders" do

      end

      it "will return an array or orders where each order is unique" do

      end

      it "will return an empty array for a Merchant with no orders" do

      end
    end

    describe "from_auth_hash" do

    end

    describe "orders_hash" do

    end

    describe "sum_ord_hash" do

    end

  end
end
