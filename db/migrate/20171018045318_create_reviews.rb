class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :review
      t.integer :rating, null: false
      t.belongs_to :product, index: true

      t.timestamps
    end
  end
end
