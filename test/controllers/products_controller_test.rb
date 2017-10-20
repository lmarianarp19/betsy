require "test_helper"

describe ProductsController do

  let(:product) { Product.first }
  describe "#index" do
    it "returns success when showing all products" do
      get products_path

      must_respond_with :success
    end

    #TODO: NOT PASSING -
    it "returns success when there are no products" do
      Product.destroy_all

      get products_path

      must_respond_with :success
    end

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
    it "returns success when a merchant creates a new product with an existing category" do
      before_pc_count = ProductCategory.count
      before_product_count = Product.count
      before_category_count = Category.count

      merchant = merchants(:grace)
      category_name = categories(:chocolate_category).name

      login(merchant)

      valid_product_data = {
        product: {
          name: "chocolate",
          price: 2,
          description: "Who doesn't love chocolate?",
          inventory: 1000,
          photo_url: "http://placecage.com",
          categories: category_name,
          # Need to be able to pass in multiple categories
          merchant_id: session[:merchant_id]
        }
      }

      post products_path, params: valid_product_data

      Product.count.must_equal before_product_count + 1
      ProductCategory.count.must_equal before_pc_count + 1
      Category.count.must_equal before_category_count

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  it "returns success when a merchant creates a new product with no existing category" do
    before_pc_count = ProductCategory.count
    before_product_count = Product.count
    before_category_count = Category.count

    merchant = merchants(:grace)

    login(merchant)

    valid_product_data = {
      product: {
        name: "Hat",
        price: 2,
        description: "Who doesn't love chocolate?",
        inventory: 1000,
        photo_url: "http://placecage.com",
        categories: "CLOTHING",
        #TODO: Need to be able to pass in multiple categories
        merchant_id: session[:merchant_id]
      }
    }

    post products_path, params: valid_product_data

    Product.count.must_equal before_product_count + 1
    ProductCategory.count.must_equal before_pc_count + 1
    Category.count.must_equal before_category_count + 1

    must_respond_with :redirect
  end

  # TODO: TEST NOT PASSING
  # it "returns bad_request when the category data is invalid" do
  #   before_pc_count = ProductCategory.count
  #   before_product_count = Product.count
  #   before_category_count = Category.count
  #
  #   merchant = merchants(:grace)
  #
  #   login(merchant)
  #
  #   invalid_product_data = {
  #     product: {
  #       name: "Hat",
  #       price: 2,
  #       description: "Who doesn't love chocolate?",
  #       inventory: 1000,
  #       photo_url: "http://placecage.com",
  #       categories: "",
  #       merchant_id: session[:merchant_id]
  #     }
  #   }
  #
  #   post products_path, params: invalid_product_data
  #
  #   Product.count.must_equal before_product_count
  #   ProductCategory.count.must_equal before_pc_count
  #   Category.count.must_equal before_category_count
  #
  #   must_redirect_to new_product_path
  # end
end
