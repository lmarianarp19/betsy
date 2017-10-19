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
      invalid_product_id = Product.last.id

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
end
