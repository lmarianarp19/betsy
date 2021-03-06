class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string   "username"
      t.string   "email"
      t.integer  "uid",        null: false
      t.string   "provider",   null: false
      t.timestamps
    end
  end
end
