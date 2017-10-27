require "test_helper"

describe OrderItemsController do
  describe "create" do
    it "must redirect to cart_path if an order_item is created and added to the cart" do
      before_count = OrderItem.count
      order_count = Order.count
      product = Product.first

      valid_data = {
        order_item: {
          quantity: 2,
          product_id: product.id
        }
      }

      post order_items_path, params: valid_data

      Order.count.must_equal order_count + 1
      OrderItem.count.must_equal before_count + 1
      session[:order_id].must_equal Order.last.id
      must_respond_with :redirect
      must_redirect_to cart_path
    end

    it "must return an error if the order_item data is invalid" do
      before_count = OrderItem.count
      order_count = Order.count
      product = Product.first

      invalid_data = {
        order_item: {
          quantity: "",
          product_id: product.id
        }
      }

      post order_items_path, params: invalid_data

      Order.count.must_equal order_count # Order is not created if the orderitem is invalid
      OrderItem.count.must_equal before_count # OrderItem is not created if the orderitem is invalid
      session[:order_id].must_be_nil
      must_respond_with :redirect
      must_redirect_to cart_path
    end
  end

  describe "#update" do
    it "returns a redirect if the order_item quantity was updated with valid data" do
      change_qty = {
        order_item: {
          quantity: 1
        }
      }

      patch order_item_path(OrderItem.first), params: change_qty

      must_respond_with :redirect
      must_redirect_to cart_path
      OrderItem.first.quantity.must_equal 1
    end

    it "returns a redirect if the order_item quantity was updated with invalid data" do
      invalid_qty = {
        order_item: {
          quantity: -1000
        }
      }

      patch order_item_path(OrderItem.first), params: invalid_qty

      must_respond_with :redirect
      must_redirect_to cart_path
      flash[:status].must_equal :failure
    end
  end

  describe "#destroy" do

    it "must redirect to cart_path if order item was successfully destroyed as a guest user" do
      # Create a new order to get an order_id in the session
      before_count = OrderItem.count
      product = Product.first

      valid_data = {
        order_item: {
          quantity: 2,
          product_id: product.id
        }
      }

      post order_items_path, params: valid_data
      current_order = Order.last
      session[:order_id].must_equal current_order.id
      OrderItem.count.must_equal before_count + 1

      delete order_item_path(current_order.order_items.last)

      OrderItem.count.must_equal before_count
      must_respond_with :redirect
      must_redirect_to cart_path
    end
  end
end
