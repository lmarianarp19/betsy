require "test_helper"

describe CartsController do
  describe "#show" do
    it "returns success if the cart has order_items and there is a current order" do
      product = Product.first

      order_item_data = {
        order_item: {
          product_id: product,
          quantity: 2
        }
      }

      post order_items_path, params: order_item_data

      get cart_path

      must_respond_with :success
      session[:order_id].must_equal Order.last.id
    end

    it "returns an empty cart if you do not have a current_order" do
      get cart_path

      must_respond_with :success
    end
  end
end
