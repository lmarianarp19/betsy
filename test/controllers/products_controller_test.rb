require "test_helper"

describe ProductsController do

  let(:product) { Product.first }
  let(:category) { Category.first}
  let(:merchant) { merchants(:grace) }


  describe "#index" do
    it "returns success when showing all products with a category" do
      get products_categories_path(category.id)

      must_respond_with :success
    end

    it "returns success when there are no products" do
      Product.destroy_all

      get products_categories_path(category.id)

      must_respond_with :success
    end

    it "returns as success when a merchant is logged in" do
      login(merchant)

      get products_categories_path(category.id)

      must_respond_with :success
    end

    it "returns flash errors when the category for a product does not exist" do
      invalid_cat_id = Category.last.id + 1

      get products_categories_path(invalid_cat_id)

      must_respond_with :not_found
    end
  end

  describe "#show" do
    it "returns success when a product is valid" do
      product.must_be :valid?

      get product_path(product)

      must_respond_with :success
    end

    it "returns not found when a product cannot be found" do
      invalid_product_id = Product.last.id + 1

      get product_path(invalid_product_id)

      must_respond_with :not_found
    end
  end

  describe "#new" do
    it "returns success when a merchant is logged in"  do
      login(merchant)

      get new_product_path

      must_respond_with :success
    end

    it "returns a redirect when a merchant is not logged in"  do
      get new_product_path

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "#create" do
    it "returns success when a merchant creates a new product with an existing category" do
      before_pc_count = ProductCategory.count
      before_product_count = Product.count
      before_category_count = Category.count

      category_name = categories(:chocolate_category).name

      login(merchant)

      valid_product_data = {
        product: {
          name: "chocolate",
          price: 2,
          description: "This is a test description of some item",
          inventory: 1000,
          photo_url: "http://placecage.com",
          # Existing Category
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
        name: "hat",
        price: 2,
        description: "This is a test description of some item",
        inventory: 1000,
        photo_url: "http://placecage.com",
        categories: "clothing",
        # TODO: Need to be able to pass in multiple categories
        merchant_id: session[:merchant_id]
      }
    }

    post products_path, params: valid_product_data

    Product.count.must_equal before_product_count + 1
    ProductCategory.count.must_equal before_pc_count + 1
    Category.count.must_equal before_category_count + 1

    must_respond_with :redirect
    flash[:status].must_equal :success
  end

  it "returns redirect to root path if the merchant is not logged in" do
    before_pc_count = ProductCategory.count
    before_product_count = Product.count
    before_category_count = Category.count

    valid_product_data = {
      product: {
        name: "clown",
        price: 2,
        description: "This is a test description of some item",
        inventory: 1000,
        photo_url: "http://placecage.com",
        categories: "toys",
        # TODO: Need to be able to pass in multiple categories
        merchant_id: nil
      }
    }

    post products_path, params: valid_product_data

    Product.count.must_equal before_product_count
    ProductCategory.count.must_equal before_pc_count
    Category.count.must_equal before_category_count

    must_respond_with :redirect
    session[:merchant_id].must_be_nil
    flash[:status].must_equal :failure
  end

  # TODO: Write a test to validate a nil form in views prior to create action  ActionView::Template::Error: First argument in form cannot contain nil or be empty

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
  #       name: "hat",
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
  #   render :new
  # end

  describe "#edit" do
    it "must return success if the product is found" do
      login(merchant)

      get edit_product_path(product)

      must_respond_with :success
    end

    it "must return not_found if the product is not found" do
      login(merchant)

      invalid_product_id = Product.last.id + 1

      get edit_product_path(invalid_product_id)

      must_respond_with :not_found
    end

    it "must redirect_to root_path if the merchant is not logged in" do
      get edit_product_path(product)

      must_respond_with :redirect
      must_redirect_to root_path
      flash[:status].must_equal :failure
    end
  end

  describe "#update" do
    it "must return success if the product is found and updated" do
      before_count = Product.count

      login(merchant)

      category_name = categories(:chocolate_category).name

      # TODO: Figure out a way to use existing yml data and pass a changed attribute as a hash
      valid_product_data = {
        product: {
          name: "chocolate",
          price: 2,
          description: "NEW DESCRIPTION OF A PREVIOUS ITEM",
          inventory: 1000,
          photo_url: "http://placecage.com",
          # Existing Category
          categories: category_name,
          # Need to be able to pass in multiple categories
          merchant_id: session[:merchant_id]
        }
      }

      patch product_path(product), params: valid_product_data

      must_respond_with :redirect
      must_redirect_to product_path(product)


      Product.count.must_equal before_count
    end

    it "must return success and create a new category if the product is updated to a new category" do
      before_count = Category.count

      login(merchant)

      valid_product_data = {
        product: {
          name: "chocolate",
          price: 2,
          description: "NEW DESCRIPTION OF A PREVIOUS ITEM",
          inventory: 1000,
          photo_url: "http://placecage.com",
          # Existing Category
          categories: "healthy",
          # Need to be able to pass in multiple categories
          merchant_id: session[:merchant_id]
        }
      }

      patch product_path(product), params: valid_product_data

      must_respond_with :redirect
      must_redirect_to product_path(product)
      Category.count.must_equal before_count + 1
    end

    it "must redirect to root_path if a merchant is not logged in" do
      valid_product_data = {
        product: {
          name: "chocolate",
          price: 2,
          description: "NEW DESCRIPTION OF A PREVIOUS ITEM",
          inventory: 1000,
          photo_url: "http://placecage.com",
          # Existing Category
          categories: "healthy",
          # Need to be able to pass in multiple categories
          merchant_id: nil
        }
      }

      patch product_path(product), params: valid_product_data

      must_respond_with :redirect
      must_redirect_to root_path
      flash[:status].must_equal :failure
    end
  end

  # TODO: DOES NOT PASS
  describe "#destroy" do
    it "returns redirect to root_path if the product status was retired to false" do
      login(merchant)
      @product = Product.last
      delete product_path(@product)

      @product.current.must_equal false
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

end
