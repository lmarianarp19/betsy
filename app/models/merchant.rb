class Merchant < ApplicationRecord
  # make sure to add and validate uid and provider when we get around to Oauth

  # relationships
  has_many :products

<<<<<<< HEAD
  def self.from_auth_hash(provider, auth_hash)
    merchant = Merchant.new
    merchant[:username] = auth_hash['info']['nickname']
    merchant[:email] = auth_hash['info']['email']
    merchant[:provider] = auth_hash['provider']
    merchant[:uid] = auth_hash['uid']
    return merchant
  end
=======
  # validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  # validates :uid, presence: true
  # validates :provider, presence: true
>>>>>>> 0a2ec6546fc65b4d74f59ff7b5f2372ef446cc2d
end
