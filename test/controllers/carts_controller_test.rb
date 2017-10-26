require "test_helper"

describe CartsController do
  describe "#show" do
    it "should return success if all the order_items in the order are valid" do
      # Create a new category and add it to the cart
      valid_data = {
        quantity: 1,
        product_id: Product.second
      }

      post orders_path, params: valid_data
      get cart_path

      must_respond_with :success
    end

    it "should return success if there are no order items in the cart" do
      OrderItem.destroy_all

      get cart_path

      must_respond_with :success
    end
  end
end
