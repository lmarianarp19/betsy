class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  has_one :payment

  validates :status, presence: true

  def self.create_new_order
    @order = Order.new # Status of pending
    if @order.save!
      return @order
    else
      flash[:status] = :failure
      flash[:message] = "There was a problem!"
    end
  end
end
