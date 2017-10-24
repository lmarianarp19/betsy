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

  def self.from_auth_hash(provider, auth_hash)
    merchant = new
    merchant.provider = provider
    merchant.uid = auth_hash['uid']
    # merchant.name = auth_hash['info']['name']
    merchant.email = auth_hash['info']['email']
    merchant.username = auth_hash['info']['nickname']
    return merchant
  end

end
