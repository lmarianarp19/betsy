class Category < ApplicationRecord
<<<<<<< HEAD

  def self.find_or_create_cat(category_name)
  existing_category = Category.find_by(name: category_name.upcase)

    if existing_category
      return category_name
    else
      new_product_cat = Category.new(name: category_name.upcase)

      if new_product_cat.save
        return new_product_cat.id
      else
        flash[:status] = :failure
        flash[:message] = "There was a problem with your category name!"
        flash[:errors] = new_product_cat.errors.messages
        redirect_to new_product_path
      end

    end
  end
=======
  has_many :product_categories
  has_many :products, through: :product_categories
>>>>>>> master
end
