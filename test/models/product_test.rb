require "test_helper"

describe Product do
  # products
  let(:first_product) {products :first_product}
  let(:first_merchant) {merchants :first_merchant}

  describe "relations" do
    it "has a merchant" do
      first_product.must_respond_to :merchant
      first_product.merchant.must_be_kind_of Merchant
    end

    it "has a list of reviews" do
      first_product.must_respond_to :reviews
      first_product.reviews.each do |review|
        review.must_be_kind_of Review
      end
    end

    it "has a list of order_items" do
      first_product.must_respond_to :order_items
      first_product.order_items.each do |order_item|
        order_item.must_be_kind_of OrderItem
      end
    end

    it "has a list of orders" do
      first_product.must_respond_to :orders
      first_product.orders.each do |order|
        order.must_be_kind_of Order
      end
    end

    it "has a list of product_categories" do
      first_product.must_respond_to :product_categories
      first_product.product_categories.each do |product_category|
        product_category.must_be_kind_of ProductCategory
      end
    end

    it "has a list of categories" do
      first_product.must_respond_to :categories
      first_product.categories.each do |category|
        category.must_be_kind_of Category
      end
    end
  end

  describe "validations" do
    describe "name" do
      it "requires a name" do
        product = Product.new
        product.valid?.must_equal false
        product.errors.messages.must_include :name
      end
      it "requires the name to be unique" do
        name = "NameMcNameFace"
        product1 = Product.new(merchant: first_merchant, price: 1000, name: name, inventory: 10)
        product1.save!

        product2 = Product.new(merchant: first_merchant, price: 1000, name: name, inventory: 10)
        product2.valid?.must_equal false
        product2.errors.messages.must_include :name
      end
    end
    describe "price" do
      it "requires a price" do
        product = Product.new
        product.valid?.must_equal false
        product.errors.messages.must_include :price
      end

      it "#price returns false if the price is not a number" do
        product1 = Product.new(merchant: first_merchant, price: "one", name: "name", inventory: 10)
        product1.valid?.must_equal false

        product2 = Product.new(merchant: first_merchant, price: [1], name: "name", inventory: 10)
        product2.valid?.must_equal false

        product3 = Product.new(merchant: first_merchant, price: Date.today, name: "name", inventory: 10)
        product3.valid?.must_equal false
      end
      it "#price returns false if the price is less than 1" do
        product1 = Product.new(merchant: first_merchant, price: 0, name: "name", inventory: 10)
        product1.valid?.must_equal false
      end

    end
    describe "merchant" do
      it "requires a merchant" do
        product = Product.new
        product.valid?.must_equal false
        product.errors.messages.must_include :merchant
      end
    end
    describe "inventory" do
      it "requires an inventory" do
        product = Product.new
        product.valid?.must_equal false
        product.errors.messages.must_include :inventory
      end
      it "returns false if the inventory is not a number" do
        product = Product.new(merchant: first_merchant, price: 1000, name: "name", inventory: "one")
        product.valid?.must_equal false
        product.errors.messages.must_include :inventory
      end
      it "returns false if the inventory is less than 0" do
        product = Product.new(merchant: first_merchant, price: 1000, name: "name", inventory: -1)
        product.valid?.must_equal false
        product.errors.messages.must_include :inventory
      end
    end
  end
end
