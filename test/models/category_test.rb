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

    end
    it "requres that the name be unique" do

    end
  end

  describe "methods" do
    describe "create_cat" do

    end
  end
end
