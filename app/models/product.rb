class Product < ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0}
  validates :inventory, presence: true, numericality: { greater_than_or_equal_to: 0}
  # TODO: Ask instructors if we need to state this validation b/c the relationship dictates that we need a merchant
  validates :merchant, presence: true
  accepts_nested_attributes_for :categories

  def categories_attributes=(category_attributes)
  category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
       # TODO: Fix this to raise a flash if blank
      if !self.categories.include? category
        self.categories << category
      end
    end
  end

  def average_rating
    if self.reviews.count > 0
      total = 0.0
      self.reviews.each do |r|
        total += r.rating
      end
       total /= self.reviews.count
       return total
    end
  end#def
end#class
