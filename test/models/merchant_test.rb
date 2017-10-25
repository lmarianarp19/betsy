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
      merchant_new.wont_be :valid?
      merchant_new.errors.messages.must_include :email
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
    it "has a list of order_items that belong to the merchant" do
      merchant_one.must_respond_to :order_items
      merchant_one.order_items.must_be_kind_of Enumerable
      merchant_one.order_items.each do |order_item|
        order_item.must_be_kind_of OrderItem
        order_item.merchant.must_equal merchant_one
      end
    end
    it "has a list of orders" do
      merchant_one.must_respond_to :orders
      merchant_one.orders.must_be_kind_of Enumerable
      merchant_one.orders.each do |order|
        order.must_be_kind_of Order
      end
    end
  end

  describe "Custom methods" do
    describe "distinct_orders" do
      it "will return an array of orders, for a merchant with orders, that includes their products" do
        results = merchant_one.distinct_orders
        results.each do |order|
          counter = 0
          order.must_be_kind_of Order
          order.products.each do |product|
            if product.merchant == merchant_one
              counter += 1
            end
          end
          counter.must_be :>, 0
        end
      end
      it "will return an array or orders where each order is unique" do
        merchant_orders = merchant_one.distinct_orders
        length = merchant_orders.length
        unique_length = merchant_orders.uniq.length
        length.must_equal unique_length
      end
      it "will return an empty array for a Merchant with no orders" do
        merchant_new.distinct_orders.must_equal []
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
