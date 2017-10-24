require "test_helper"

describe PaymentsController do
  describe "new" do
    it "returns success when making a new payment" do
      get new_order_payment_path(Order.first.id)
      must_respond_with :success
    end

    it "returns failure when making a new payment the order doesn't exists" do
      get new_order_payment_path(Order.last.id + 1)
      must_respond_with :not_found
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
      post order_payments_path(payment.order_id), params: payment_data
      must_respond_with :redirect
      #TODO put the right route
      #must_redirect_to product_path(payment_data[:payment][:product_id])


      Payment.count.must_equal before_count + 1
    end

    it "returns failure when data is bogus" do
      before_count = Payment.count

      wrong_payment_data = {
        payment: {
          email: "ahoraonunca@hotmaol.com",
          mailing_address: "New York",
          cc_name: "Carolina Herrera",
          cc_expiration: Date.new(2018,2),
          cc_number: 123,
          cc_ccv: 123,
          billing_zip: 12345,
          order_id: Order.first.id
        }
      }

      payment = Payment.new(wrong_payment_data[:payment])
      post order_payments_path(payment.order_id), params: wrong_payment_data
      must_respond_with :bad_request
      Payment.count.must_equal before_count

    end
  end #describe create
end#last
