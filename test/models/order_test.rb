require "test_helper"

describe Order do
  # products
  let(:first_product) {products :first_product}
  let(:second_product) {products :second_product}
  let(:third_product) {products :third_product}
  # orders
  let(:first_order) {orders :first_order}
  let(:second_order) {orders :second_order}

  describe "relations" do
    it "has a list of products" do
      first_order.must_respond_to :products
      first_order.products.count.must_be :>, 1
      first_order.products.each do |product|
        product.must_be_kind_of Product
      end
    end

    it "has a list of order_items" do
      first_order.must_respond_to :order_items
      first_order.order_items.count.must_be :>, 1
      first_order.order_items.each do |oi|
        oi.must_be_kind_of OrderItem 
      end
    end
  #   it "has a single payment" do
  #
  #   end
  #
  #   it "cannot have more than one payment" do
  #
  #   end
  end
  #
  # describe "validations" do
  #   it "require a status" do
  #
  #   end
  #
  #   # TODO: ask if we need to test default value? AKA do we need to test that status defaults to "pending?"
  # end
end
