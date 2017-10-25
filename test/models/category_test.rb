require "test_helper"

describe Category do
  let(:first_catagory) {categories :fruit_category}

  describe "relations" do
    it "has a collection of products" do
      first_catagory.must_respond_to :products
      first_catagory.products.each do |product|
        product.must_be_kind_of Product
      end
    end
    it "has a collection of product_categories" do

    end
  end

  describe "validations" do
    it "requires a name" do
      first_catagory.name = nil
      first_catagory.valid?.must_equal false
    end

    it "requres that the name be unique" do
      not_unique = Category.new(name: "fruit_category")
      not_unique.valid?.must_equal false
    end
  end

  describe "methods" do
    describe "#create_cat" do

      it "Can create a new instance of category" do
        count = Category.all.count
        example = Category.create_cat("droids")
        example.must_be_kind_of Category
        example.valid?.must_equal true
        count.must_equal Category.count, +1

      end

    end
  end
end
