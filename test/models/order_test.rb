require "test_helper"

describe Order do
  # orders
  let(:first_order) {orders :first_order}
  let(:second_order) {orders :second_order}
  # payments
  let(:payment_one) {payments :payment_one}

  describe "relations" do
    it "has a list of products" do
      first_order.must_respond_to :products
      first_order.products.count.must_be :>, 1
      first_order.products.each do |product|
        product.must_be_kind_of Product
      end
    end

    it "has a list of order_items" do
      first_order.must_respond_to :order_items
      first_order.order_items.count.must_be :>, 1
      first_order.order_items.each do |oi|
        oi.must_be_kind_of OrderItem
      end
    end

    it "has a payment" do
      first_order.must_respond_to :payment
      first_order.payment = payment_one
      first_order.payment.must_be_kind_of Payment
    end
  end

  describe "validations" do
    it "#Status attribute defualts to 'pending'" do
      order = Order.new
      order.status.must_equal "pending"
    end

    it "requires a status" do
      order = Order.new
      order.status = ''
      order.valid?.must_equal false
      order.errors.messages.must_include :status
    end
  end

  describe "custom methods" do
    describe "calculate_total" do
      it "will return an integer that equals the total revenue for a given order" do
        # arrange
        expected = 0
        first_order.order_items.each do |oi|
          expected += oi.product.price * oi.quantity
        end
        # act
        actual = first_order.calculate_total
        # assert
        actual.must_equal expected
        actual.must_be_kind_of Integer
      end

      it "it will return 0 for an order without any order_items" do
        Order.new.calculate_total.must_equal 0
      end
    end
  end

  describe 'change_to_shipped' do
    it "will update and orders status to 'complete' if all of an orders order_items have been shipped, returns complete" do
      first_order.status.wont_equal "complete"
      first_order.order_items.each do |oi|
        oi.shipped.must_equal true
      end
      first_order.change_to_shipped.must_equal "complete"
      # first_order.status.must_equal "complete"
    end

    it "will not change an orders status if all of the order_items have not been shipped, returns complete" do
      second_order.status.wont_equal "complete"
      second_order.order_items.each do |oi|
        oi.shipped.must_equal false
      end
      second_order.change_to_shipped.wont_equal "complete"
      # second_order.status.wont_equal "complete"
    end

    it "will return nil for a Order with no order_items" do
      Order.new.change_to_shipped.must_equal nil
    end
  end
end
