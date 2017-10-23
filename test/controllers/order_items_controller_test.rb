require "test_helper"

describe OrderItemsController do

  # TODO: REFACTOR PRODUCT DATA
  describe "create" do
    it "must add a new Order item" do
      
    end

    # it "must redirect and create a new order and order item" do
    #   before_count = Order.count
    #   before_item_count = OrderItem.count
    #
    #   # merchant = merchants(:grace)
    #   product = Product.first
    #   # category_name = categories(:chocolate_category).name
    #
    #   valid_product_data = {
    #     product: {
    #       id: product.id,
    #       name: product.name,
    #       price: product.price,
    #       description: product.description,
    #       inventory: product.inventory,
    #       photo_url: product.photo_url,
    #       merchant_id: product.merchant_id
    #     }
    #   }
    #
    #   product.must_be :valid?
    #
    #   post order_items_path, params: valid_product_data
    #
    #   Order.count.must_equal before_count + 1
    #   OrderItem.count.must_equal before_item_count + 1
    #   must_respond_with :redirect
    #   must_redirect_to product_path(product)
    #   session[:order_id].must_equal Order.last.id
    # end
    #
    # it "returns redirect, adds a new order_item, and a new order is not created" do
    #   product = Product.first
    #
    #   valid_product_data = {
    #     product: {
    #       id: product.id,
    #       name: product.name,
    #       price: product.price,
    #       description: product.description,
    #       inventory: product.inventory,
    #       photo_url: product.photo_url,
    #       merchant_id: product.merchant_id
    #     }
    #   }
    #
    #   product.must_be :valid?
    #
    #   ####### ADD FIRST PRODUCT TO ORDER
    #   post order_items_path, params: valid_product_data
    #
    #   before_count = Order.count
    #   before_item_count = OrderItem.count
    #
    #   product_2 = Product.last
    #
    #   valid_product_data_2 = {
    #     product: {
    #       id: product_2.id,
    #       name: product_2.name,
    #       price: product_2.price,
    #       description: product_2.description,
    #       inventory: product_2.inventory,
    #       photo_url: product_2.photo_url,
    #       merchant_id: product_2.merchant_id
    #     }
    #   }
    #
    #   ######## ADD SECOND PRODUCT TO ORDER
    #   post order_items_path, params: valid_product_data_2
    #
    #   Order.count.must_equal before_count
    #   OrderItem.count.must_equal before_item_count + 1
    #   must_respond_with :redirect
    #   must_redirect_to product_path(product_2)
    #   session[:order_id].must_equal Order.last.id
    # end
  end
end
