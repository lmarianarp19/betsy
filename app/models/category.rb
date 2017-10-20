class Category < ApplicationRecord

  has_many :product_categories
  has_many :products, through: :product_categories


  def self.create_cat(input_name)
    category = Category.new(name: input_name)

    if category.save
      return category
    else
      flash[:status] = :failure
      flash[:message] = "There was a problem with your category name!"
      flash[:errors] = new_product_cat.errors.messages
      redirect_to new_product_path
    end
  end

end
