class Merchant < ApplicationRecord
  # make sure to add and validate uid and provider when we get around to Oauth
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  # relationships
  has_many :products, dependent: :destroy
  has_many :order_items, through: :products
  has_many :orders, through: :order_items

  # def self.from_auth_hash(provider, auth_hash)
  #   merchant = Merchant.new
  #   merchant[:username] = auth_hash['info']['nickname']
  #   merchant[:email] = auth_hash['info']['email']
  #   merchant[:provider] = auth_hash['provider']
  #   merchant[:uid] = auth_hash['uid']
  #   return merchant
  # end

  # validates :uid, presence: true
  # validates :provider, presence: true

  #TODO: merchant is not getting the username

  def self.from_auth_hash(provider, auth_hash)
    merchant = new
    merchant.provider = provider
    merchant.uid = auth_hash['uid']
    # merchant.name = auth_hash['info']['name']
    merchant.email = auth_hash['info']['email']
    merchant.username = auth_hash['info']['nickname']
    return merchant
  end



  def to_orders_hash(orders, merchant)
    data = {}
    orders.each do |order|
      data[order] = []
      a = by_order(order)
      a.each do |order_item|
        if order_item.merchant == arb
          data[order] << order_item
        end
      end
    end
    return data
  end

  def self.by_order(order)
    self.where(order: order)
  end

  def orders_hash
    data = {}
    self.orders.distinct.each do |order|
      # merch_ois = order.order_items.select { |oi| oi.merchant == self }
      data[order] = order.order_items.select { |oi| oi.merchant == self }
      # merch_ois = order.order_items.select { |oi| oi.merchant == self }
      # data << { order: order, order_items: merch_ois}
    end
    return data
  end

  def orders_hash_by_status(order_status)
    var = self.orders_hash
    return var.select{ |k,v| k.status == order_status}
  end
end
