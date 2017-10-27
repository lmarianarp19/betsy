require "test_helper"

describe PaymentsController do
  let(:payment_data_good){
    {
      payment: {
        email: "ahoraonunca@hotmaol.com",
        mailing_address: "New York",
        cc_name: "Carolina Herrera",
        cc_expiration: Date.new(2018,2),
        cc_number: 1234567898765432,
        cc_ccv: 123,
        billing_zip: 12345,
        order_id: Order.last.id,
        name: "Carolina Herrera"
      }
    }
  }

  let(:merchant) { merchants(:grace) }
  let(:product) { products(:fourth_product) }
  let(:order){Order.new(status: "paid")}
  let(:order_item){OrderItem.new(quantity: 1, order: order, product: product, shipped: false)}
  let(:payment_good) {Payment.new(payment_data_good[:payment])}


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
      payment_good.must_be :valid?
      post order_payments_path(payment_good.order_id), params: payment_data_good
      must_respond_with :redirect
      must_redirect_to order_path(payment_good.order_id)

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

  describe "show" do
    describe "guest" do
      it "returns failure when a guest tries to view a payments show page" do
        get payment_path(payment_good.order_id)
        must_redirect_to root_path
        must_respond_with :found
        flash[:status].must_equal :failure
      end
    end

    describe "logged in merchant" do
      it "returns success when merchant views the payment page of an order that includes the merchants products" do
        login(merchant)
        order_item.save!
        payment_good.save
        get payment_path(payment_good.id)
        must_respond_with :success
      end
      it "returns failure when a logged in user tries to access a payments view page whose order doesn't include thier products" do
        login(merchant)
        get payment_path(Payment.first.id)
        must_respond_with :found
        flash[:status].must_equal :failure
        flash[:message].must_equal "You must be authorized to do that"
      end
      it "will redirect if the payment id doesn't exist" do
        login(merchant)
        get payment_path(Payment.last.id + 1)
        flash[:status].must_equal :failure
      end
    end
  end#describe show
end#last
