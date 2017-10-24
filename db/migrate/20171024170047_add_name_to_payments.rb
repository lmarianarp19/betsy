class AddNameToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :name, :string
  end
end
