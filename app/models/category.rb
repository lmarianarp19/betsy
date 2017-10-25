class Category < ApplicationRecord

  has_many :product_categories
  has_many :products, through: :product_categories
  # TODO: Add regex to validate that category names are only letters
  validates :name, presence: true, uniqueness: true

  # def self.create_cat(input_name)
  #   category = Category.new(name: input_name)
  #   return category
  # end

end
