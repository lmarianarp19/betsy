class Merchant < ApplicationRecord
  # make sure to add and validate uid and provider when we get around to Oauth

  # relationships
  has_many :products

  # validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  # validates :uid, presence: true
  # validates :provider, presence: true
end
