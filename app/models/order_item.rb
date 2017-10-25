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
end
