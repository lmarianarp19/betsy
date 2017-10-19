class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :email
      t.string :mailing_address
      t.string :cc_name
      t.string :cc_expiration
      t.string :cc_number
      t.string :cc_ccv
      t.string :billing_zip

      t.timestamps
    end
  end
end
