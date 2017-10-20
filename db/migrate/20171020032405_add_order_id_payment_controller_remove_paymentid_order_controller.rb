class AddOrderIdPaymentControllerRemovePaymentidOrderController < ActiveRecord::Migration[5.1]
  def change
    add_column(:payments, :order_id, :bigint)
    remove_column(:orders, :payment_id)
  end
end
