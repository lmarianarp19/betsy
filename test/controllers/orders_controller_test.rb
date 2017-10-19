require "test_helper"

describe OrdersController do
  describe "show" do
    it "succeeds for an order that exists" do
        order_id = Order.first.id
        get order_path(order_id)
        must_respond_with :success
      end
  end
end
