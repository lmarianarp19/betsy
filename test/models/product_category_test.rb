require "test_helper"

describe ProductCategory do
  let(:pc_one) {product_categories :product_category_one}
  let(:third_product) {products :third_product}
  let(:first_category) {categories :fruit_category}

  describe "relationships" do
    it "has a product" do
      pc_one.must_respond_to :product
      pc_one.product.must_be_kind_of Product
    end
    it "has a category" do
      pc_one.must_respond_to :category
      pc_one.category.must_be_kind_of Category
    end
  end

  describe "validations" do
    it "it doesn't allow the same product category combination to happen twice, AKA product_categories must be a unique combination of the two" do
      pc1 = ProductCategory.new(product: third_product, category: first_category)
      pc1.save!

      pc2 = ProductCategory.new(product: third_product, category: first_category)
      pc2.valid?.must_equal false
      pc2.errors.messages.must_include :product_id
    end
  end

  # describe "custom methods" do
  #   describe "create_prod_cat" do
  #
  #   end
  # end
end
