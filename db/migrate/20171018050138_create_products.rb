class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.integer :inventory
      t.string :photo_url
      t.integer :merchant_id
      t.boolean :current, default: true
      t.integer :category_id
      t.timestamps
    end
  end
end
