class OrderItem < ApplicationRecord
  # relationships
  belongs_to :product
  belongs_to :order
  has_one :merchant, through: :product

  # validations
  validates_uniqueness_of :order_id, :scope => :product_id
  validates :quantity, presence: true, numericality: { greater_than: 0}

  def line_item_total
    price = self.product.price
    quantity = self.quantity
    total = price * quantity
    return total
  end

  def self.to_orders_hash(orders, arb)
    data = {}
    orders.each do |order|
      data[order.id] = []
      a = by_order(order)
      a.each do |order_item|
        if order_item.merchant == arb
          data[order.id] << order_item
        end
      end
    end
    return data
  end

  def self.by_order(order)
    self.where(order: order)
  end
end
