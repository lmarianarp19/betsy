class Order < ApplicationRecord
  CATEGORIES = %w(paid complete)
  has_many :order_items
  has_many :products, through: :order_items
  has_one :payment

  validates :status, presence: true

  #TODO test calculate total

  def calculate_total
    self.order_items.collect { |item| item.product.price * item.quantity}.sum
  end


  def ords
    
  end

  def to_orders_hash(orders, merchant)
    data = {}
    orders.each do |order|
      data[order] = []
      a = by_order(order)
      a.each do |order_item|
        if order_item.merchant == arb
          data[order] << order_item
        end
      end
    end
    return data
  end

  def self.by_order(order)
    self.where(order: order)
  end
end
