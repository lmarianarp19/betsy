require "test_helper"

describe ProductsController do

  let(:product) { Product.first }
  describe "#index" do
    it "returns success when showing all products" do
      get products_path

      must_respond_with :success
    end

    #TODO: Need to make an alternative edge case of when a product is invalid
  end

  describe "#show" do
    it "returns success when a product is valid" do
      product.must_be :valid?

      get product_path(product.id)

      must_respond_with :success
    end

    it "returns not found when a product cannot be found" do
      invalid_product_id = Product.last.id + 1

      get product_path(invalid_product_id)

      must_respond_with :not_found
    end
  end

  describe "#new" do
    it "returns success when a new product is created" do
      get new_product_path

      must_respond_with :success
    end
  end

  describe "#edit" do
    it "must return success if the product is found" do
      get edit_product_path(product.id)

      must_respond_with :success
    end

    it "must return not_found if the product is not found" do
      invalid_product_id = Product.last.id + 1

      get edit_product_path(invalid_product_id)

      must_respond_with :not_found
    end
  end

  describe "#create" do
    it "returns success for a different merchant if the same product_category exists" do
      

      # before_count = Product.count
      #
      # # session[:merchant_id] = 13371337
      #
      # valid_product_data = {
      #   product: {
      #     name: "CHOCOLATE",
      #     price: 2,
      #     description: "Who doesn't love chocolate?",
      #     inventory: 1000,
      #     photo_url: "http://placecage.com",
      #   }
      # }
      #
      # post products_path, params: valid_product_data
      #
      # Product.count.must_equal before_count + 1
      #
      # must_respond_with :redirect
    end
  end

end
