class ProductCategory < ApplicationRecord
  # relationships
  belongs_to :product
  belongs_to :category

  # validations
  validates_uniqueness_of :product_id, :scope => :category_id
end
