class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  has_one :payment

  validates :status, presence: true

  #TODO test calculate total

  def calculate_total
    self.order_items.collect { |item| item.product.price * item.quantity}.sum 
  end
end
