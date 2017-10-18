class AddRefToProductForCategory < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :category_id
    add_reference :products, :category, index: true, foreign_key: true
  end
end
