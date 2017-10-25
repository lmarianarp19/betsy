class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  has_one :payment

  validates :status, presence: true

  #TODO test calculate total

  def calculate_total
    self.order_items.collect { |item| item.product.price * item.quantity}.sum
  end

  def ship_order
    all_items = self.order_items
    all_items.each do |order_item|
      if order_item.shipped == false
        return false
      end
    end
    return true
  end

  def change_to_shipped
    if self.ship_order
      return self.status = "complete"
    end
  end
end
