class AddCatIdToProductTesting < ActiveRecord::Migration[5.1]
  def change
      add_column :products, :category_id, :bigint
  end
end
