require "test_helper"

describe OrderItem do
  let(:order_item) { OrderItem.new }

  describe "relations" do
    it "has a product" do

    end

    it "has a order" do

    end
  end

  describe "validations" do
    it "allows one product to have many orders" do

    end

    it "allows one order to have multiple products" do

    end

    it "it doesn't allow the same product to appear twice in an order" do

    end

    it "requires a quantity" do

    end

    it "quantity must be a number and must be greater than 0" do

    end
  end
end
