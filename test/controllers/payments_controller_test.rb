require "test_helper"

describe PaymentsController do
  describe "new" do
    it "returns success when making a new payment" do
      #call session with order_id
      #@order_item = OrderItem.new
      # @order = current_order
      # #@item = @order.order_items.new(order_items_params)
      # @order.save
      # session[:order_id] = @order.id
      #redirect_to products_path
      get new_order_payment_path(:order_id)
      must_respond_with :success
    end
  end #describe new

  describe "create" do
    it "returns success when saving a payment" do
      before_count = Payment.count

      payment_data = {
        payment: {
          email: "ahoraonunca@hotmaol.com",
          mailing_address: "New York",
          cc_name: "Carolina Herrera",
          cc_expiration: Date.new(2018,2),
          cc_number: 1234567898765432,
          cc_ccv: 123,
          billing_zip: 12345,
          order_id: Order.first.id
        }
      }

      payment = Payment.new(payment_data[:payment])
      payment.must_be :valid?
      #binding.pry
      post order_payments_path(payment.order_id), params: payment_data
      must_respond_with :redirect
      #  must_redirect_to product_path(review_data[:review][:product_id])

      # must_redirect_to product_path(review_data[:review][:product_id])
      # Review.count.must_equal before_count + 1

      #  Review.count.must_equal before_count + 1
    end
  end #describe create
end#last
