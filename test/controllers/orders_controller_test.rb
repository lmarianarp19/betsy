require "test_helper"

describe OrdersController do

  let(:merchant) { merchants(:grace) }

  describe "index" do
    # it "returns success and shows all orders if merchant is logged in" do
    #   # m = Merchant.first
    #   # login(m)
    #   #
    #   # get merchant_orders_path(m)
    #   #
    #   # must_respond_with :success
    # end

    it "returns success if there is are no orders for a logged in merchant" do
      Order.destroy_all
      login(merchant)

      get merchant_orders_path(merchant)

      must_respond_with :success
    end

    it "redirects to root_path if the merchant is not logged in" do
      get merchant_orders_path(merchant)

      flash[:status] = :failure
      must_respond_with :redirect
      must_redirect_to root_path
    end

    #TODO: Make tests around if another user attempts to access the another merchant info
  end

  describe "show" do
    it "succeeds for an order that exists" do
      order_id = Order.second.id
      get order_path(order_id)

      must_respond_with :success
    end

    it "returns not_found for an that does not exists" do
      order_id = Order.last.id + 1
      get order_path(order_id)
      must_respond_with :not_found
    end
  end

  # describe "create" do
  #       it "adds the order to the DB id data is valid" do
  #        # Arrange
  #        order_data = {
  #          order: {
  #            status: "pending"
  #            #payment_id: Payment.first.id
  #          }
  #        }
  #        start_order_count = Order.count
  #        Order.create(order_data[:order]).must_be :valid?
  #        post orders_path, params: order_data
  #      end
  #    end

  # describe  "#destroy" do
  #   it "can change status" do
  #     order = Order.first
  #
  #     delete order_path(order)
  #
  #     must_respond_with :success
  #
  #     order.reload
  #     Order.first.wont_equal order
  #   end

  # end
end #first describe
