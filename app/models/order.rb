class Order < ApplicationRecord
  CATEGORIES = %w(paid complete)
  has_many :order_items
  has_many :products, through: :order_items
  has_one :payment

  validates :status, presence: true

  #TODO Test calculate total

  #TODO Can we use line_item_total here?

  def calculate_total
    self.order_items.collect { |item| item.product.price * item.quantity}.sum
  end

  def ship_order
    all_items = self.order_items
    if all_items.empty?
      return false
    else
      all_items.each do |order_item|
        if order_item.shipped == false
          return false
        end
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
