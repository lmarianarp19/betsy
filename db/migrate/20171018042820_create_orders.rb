class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string "status", default: "pending", null: false

      t.timestamps
    end
  end
end
