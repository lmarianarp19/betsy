require "test_helper"

describe OrdersController do
  describe "index" do

  end

  describe "show" do
    it "succeeds for an order that exists" do
        order_id = Order.second.id
        get order_path(order_id)
        must_respond_with :success
      end

    it "returns not_found for a book that doens't exists" do
        order_id = Order.last.id + 1
        get order_path(order_id)
        must_respond_with :not_found
      end
  end

 describe "create" do
       it "adds the order to the DB id data is valid" do
        # Arrange
        order_data = {
          order: {
            status: "pending"
            #payment_id: Payment.first.id
          }
        }
        start_order_count = Order.count
        Order.create(order_data[:order]).must_be :valid?
        post orders_path, params: order_data
      end
    end

  describe  "update" do
    it "can change status" do
      order = Order.first

    end

  end
  end #first describe
