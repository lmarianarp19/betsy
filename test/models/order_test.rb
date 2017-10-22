require "test_helper"

describe Order do
  # orders
  let(:first_order) {orders :first_order}
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
    # TODO: Ask instructors how to test this?
    # it "cannot have more than one payment" do
    #
    # end
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





  #   # TODO: ask if we need to test default value? AKA do we need to test that status defaults to "pending?"
  end
end
