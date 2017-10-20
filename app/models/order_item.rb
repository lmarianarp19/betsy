class OrderItem < ApplicationRecord
  # relationships
  belongs_to :product
  belongs_to :order

  # validations
  validates_uniqueness_of :order_id, :scope => :product_id
  validates :quantity, presence: true, numericality: { greater_than: 0} 
end
