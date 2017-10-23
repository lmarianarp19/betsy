class AddShippedBooleanOrderitems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :shipped, :boolean, default: false
  end
end
