class MerchantsRemoveNullConstraint < ActiveRecord::Migration[5.1]
  def change
    change_column_null :merchants, :uid, true
    change_column_null :merchants, :provider, true
  end
end
