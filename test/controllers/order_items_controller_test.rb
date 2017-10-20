require "test_helper"

describe OrderItemsController do
  describe "create" do
    it "must return success if an order_item is created" do
      before_count = OrderItem.count
      product_id = Product.first.id
      order_id = Order.first.id

      valid_data = {
        order_item: {
          quantity: 2,
          product: product_id,
          order_id: order_id
          #TODO: This needs to the the current order that was created when the first item was created
        }
      }

      post orderitems_path, params: valid_data

      must_respond_with :success

      OrderItem.count.must_equal before_count + 1
    end
  end
end
