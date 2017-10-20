class ChangeCcExpirationToBeDateInPayments < ActiveRecord::Migration[5.1]
  def change
    change_column :payments, :cc_expiration, 'date USING CAST(cc_expiration AS date)'
  end
end
