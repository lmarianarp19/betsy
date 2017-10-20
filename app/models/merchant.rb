class Merchant < ApplicationRecord
  # make sure to add and validate uid and provider when we get around to Oauth

  # relationships
  has_many :products

  # validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
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
