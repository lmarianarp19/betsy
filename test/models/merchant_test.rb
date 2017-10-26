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

    describe "orders_hash" do
      it "for a user with orders it returns a hash where the keys are orders and the values are order items that belong the merchant" do
        # hash
        o_hash = merchant_one.orders_hash
        o_hash.must_be_kind_of Hash

        # keys are orders
        o_hash.keys.each do |order|
          order.must_be_kind_of Order
        end

        # values are order_items that belong to merchant
        o_hash.values.flatten.each do |order_item|
          order_item.must_be_kind_of OrderItem
          order_item.merchant.must_equal merchant_one
        end
      end

      it "returns an empty hash when no one has ordered a merchants products" do
        merchant_new.orders_hash.must_equal Hash.new
      end
    end

    describe "orders_hash_by_status" do
      # this is basically the same as orders_hash except that you pass an order status through the method that acts as a filter
      # success case user has orders and valid arg
      it "will return a hash with only orders that match a valid status passed into method" do
        merchant_one.orders_hash_by_status("complete").keys.each do |order|
          order.status.must_equal "complete"
        end
        merchant_one.orders_hash_by_status("pending").keys.each do |order|
          order.status.must_equal "pending"
        end
      end

      it "returns an empty hash if a merchant has no orders" do
        merchant_new.orders_hash_by_status("pending").must_equal Hash.new
      end

      it "returns an emtpy hash if call this method with invalid arguements for a merchant, with or without orders" do
        invalid_arguments = [[1],1,Date.today,"yoda", merchant_one]
        invalid_arguments.each do |bad_arg|
          merchant_one.orders_hash_by_status(bad_arg).must_equal Hash.new
          merchant_new.orders_hash_by_status(bad_arg).must_equal Hash.new
        end
      end
    end

    describe "sum_ord_hash" do
      #success case, orders
      it "will return the total marchant revenue for orders of a given status" do
        # arrange
        #find all a merchants order items for orders with a given status
        m1_pend_ords = merchant_one.distinct_orders.where(status: "pending")
        merchants_ois = []
        m1_pend_ords.each do |order|
          order.order_items.each do |oi|
            if oi.merchant == merchant_one
              merchants_ois << oi
            end
          end
        end
        # calculate expected revenue
        expected = 0
        merchants_ois.each do |oi|
          expected += (oi.product.price * oi.quantity)
        end
        # act
        actual = merchant_one.sum_ord_hash("pending")
        # assert
        expected.must_equal actual
      end
      it "will return 0 for merchants with no order or with any entry of invalid data" do
        invalid_arguments = [[1],1,Date.today,"yoda", merchant_one]
        invalid_arguments.each do |bad_arg|
          merchant_one.sum_ord_hash(bad_arg).must_equal 0
          merchant_new.sum_ord_hash(bad_arg).must_equal 0
        end
      end
    end
  end
end
