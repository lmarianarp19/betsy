class CreatePaymentsOrderRelationship < ActiveRecord::Migration[5.1]
  def change
    create_table :payments_order_relationships do |t|
      add_reference :orders, :payment, index: true
    end
  end
end
