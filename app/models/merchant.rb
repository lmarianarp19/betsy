class Merchant < ApplicationRecord
  # Relationships
  has_many :products, dependent: :destroy
  has_many :order_items, through: :products
  has_many :orders, through: :order_items

  # Make sure to add and validate uid and provider when we get around to Oauth
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def self.from_auth_hash(provider, auth_hash)
    merchant = new
    merchant.provider = provider
    merchant.uid = auth_hash['uid']
    merchant.email = auth_hash['info']['email']
    merchant.username = auth_hash['info']['nickname']
    return merchant
  end

  def orders_hash
    data = {}
    self.distinct_orders.each do |order|
      data[order] = order.order_items.select { |oi| oi.merchant == self }
    end
    return data
  end

  def orders_hash_by_status(order_status)
    var = self.orders_hash
    return var.select{ |k,v| k.status == order_status}
  end

  def distinct_orders
    return self.orders.distinct
  end

  def sum_ord_hash(order_status)
    var = self.orders_hash_by_status(order_status)
    return var.values.flatten.inject(0) {|sum, oi| sum + oi.line_item_total}
  end
end
