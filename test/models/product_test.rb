require "test_helper"

describe Product do
  # products
  let(:first_product) {products :first_product}
  let(:first_merchant) {merchants :first_merchant}
  let(:cat_att_hash_new) {{"0"=>{"name"=>"Ewok"}}}
  let(:cat_att_hash_old) {{"0"=>{"name"=>"jedi_category"}}}
  let(:new_product) {Product.new}
  let(:category) {categories :fruit_category}

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
        new_product.valid?.must_equal false
        new_product.errors.messages.must_include :name
      end
      it "requires the name to be unique" do
        name = "NameMcNameFace"
        product1 = Product.new(merchant: first_merchant, price: 1000, name: name, inventory: 10, category: category)
        product1.save!

        product2 = Product.new(merchant: first_merchant, price: 1000, name: name, inventory: 10, category: category)
        product2.valid?.must_equal false
        product2.errors.messages.must_include :name
      end
    end

    describe "price" do
      it "requires a price" do
        new_product.valid?.must_equal false
        new_product.errors.messages.must_include :price
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


    describe "category" do
      it "requires a category" do
        new_product.valid?.must_equal false
        new_product.errors.messages.must_include :categories
      end
    end

    describe "merchant" do
      it "requires a merchant" do
        new_product.valid?.must_equal false
        new_product.errors.messages.must_include :merchant
      end
    end


    describe "inventory" do
      it "requires an inventory" do
        new_product.valid?.must_equal false
        new_product.errors.messages.must_include :inventory
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

    describe "current" do
      it "#current attribute defualts to 'true'" do
        new_product.current.must_equal true
      end
    end
  end

  describe "custom methods" do
    describe "average_rating" do
      it "will return the average rating for a product" do
        expected = 0.0
        first_product.reviews.each do |review|
          expected += review.rating
        end
        expected /= first_product.reviews.count
        actual = first_product.average_rating
        actual.must_equal expected
      end

      it "will return nil for a product without reviews" do
        new_product.average_rating.must_be_nil
      end
    end

    describe "category_attributes=" do
      describe "Category already exists" do
        it "will assign the existing category to a product, for a product that doesn't have that category" do
          before = new_product.categories.length
          new_product.categories_attributes=(cat_att_hash_old)
          new_product.categories.length.must_equal before + 1
          # there must be a better way to test this... but I'm not sure how - SRB
          new_product.categories.first.name.must_equal cat_att_hash_old.values[0].values[0]
        end

        it "it will do nothing if a product already has the category assigned to it" do
          new_product.categories_attributes=(cat_att_hash_old)
          before = new_product.categories.length
          new_product.categories_attributes=(cat_att_hash_old)
          new_product.categories.length.must_equal before
        end
      end

      describe "New category" do
        it "will assign the category to a product" do
          # arrange
          new_category_name = cat_att_hash_new.values[0].values[0]
          Category.find_by(name: new_category_name).must_be_nil
          before = new_product.categories.length

          # act
          new_product.categories_attributes=(cat_att_hash_new)

          # assert
          new_product.categories.length.must_equal before + 1
        end
      end
    end
  end
end
