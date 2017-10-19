class Merchant < ApplicationRecord
  has_many :products

  def self.from_auth_hash(provider, auth_hash)
    merchant = Merchant.new
    merchant[:username] = auth_hash['info']['nickname']
    merchant[:email] = auth_hash['info']['email']
    merchant[:provider] = auth_hash['provider']
    merchant[:uid] = auth_hash['uid']
    return merchant
  end
end
