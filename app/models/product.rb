class Product < ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :order_items
  has_many :orders, through: :order_items
end