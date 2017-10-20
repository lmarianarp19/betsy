class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  has_one :payment

  validates :status, presence: true
end
