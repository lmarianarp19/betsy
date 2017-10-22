require "test_helper"

describe OrderItem do
  # products
  let(:first_product) {products :first_product}
  let(:second_product) {products :second_product}
  let(:third_product) {products :third_product}
  # orders
  let(:first_order) {orders :first_order}
  let(:second_order) {orders :second_order}
  # order_items
  let(:order_item_one) {order_items :order_item_one}
  let(:order_item_two) {order_items :order_item_two}
  let(:order_item_three) {order_items :order_item_three}

  describe "relations" do
    it "has a product" do
      order_item_one.must_respond_to :product
      order_item_one.product.must_be_kind_of Product
    end

    it "has a order" do
      order_item_one.must_respond_to :order
      order_item_one.order.must_be_kind_of Order
    end

    it "allows one product to have many orders" do
      first_product.orders.count.must_be :>, 1
      first_product.orders.must_include first_order
      first_product.orders.must_include second_order
    end

    it "allows one order to have multiple products" do
      first_order.products.count.must_be :>, 1
      first_order.products.must_include first_product
      first_order.products.must_include second_product
    end
  end

  describe "validations" do
    it "it doesn't allow the same product to appear twice in an order" do
      oi1 = OrderItem.new(order: first_order, product: third_product, quantity: 1)
      oi1.save!

      oi2 = OrderItem.new(order: first_order, product: third_product, quantity: 1)
      oi2.valid?.must_equal false
      oi2.errors.messages.must_include :order_id
    end

    it "requires a quantity" do
      oi = OrderItem.new(order: first_order, product: third_product)
      result = oi.save
      result.must_equal false
      oi.errors.messages.must_include :quantity
    end

    it "return false if quanity is not a number" do
      oi = OrderItem.new(order: first_order, product: third_product, quantity: "a")
      oi.valid?.must_equal false

      oi2 = OrderItem.new(order: first_order, product: third_product, quantity: [1])
      oi2.valid?.must_equal false

      oi3 = OrderItem.new(order: first_order, product: third_product, quantity: Date.today)
      oi3.valid?.must_equal false
    end

    it "returns false if quanity is less than 1" do
      oi = OrderItem.new(order: first_order, product: third_product, quantity: 0)
      oi.valid?.must_equal false

      oi2 = OrderItem.new(order: first_order, product: third_product, quantity: -1.0)
      oi2.valid?.must_equal false
    end

    it "requires a product" do
      oi = OrderItem.new(order: first_order, quantity: 1)
      result = oi.save
      result.must_equal false
      oi.errors.messages.must_include :product
    end

    it "requires a order" do
      oi = OrderItem.new(product: third_product, quantity: 1)
      result = oi.save
      result.must_equal false
      oi.errors.messages.must_include :order
    end
  end
end
