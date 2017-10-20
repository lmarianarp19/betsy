class Review < ApplicationRecord
  belongs_to :product

  validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}


  # validates :rating, :inclusion => { :in => 1..5 }

end
