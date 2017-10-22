class Product < ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0}
  # TODO: Ask instructors if we need to state this validation b/c the relationship dictates that we need a merchant
  validates :merchant, presence: true
end
