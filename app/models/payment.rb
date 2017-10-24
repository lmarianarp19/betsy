class Payment < ApplicationRecord
  has_one :order

  validates :name, presence: {message: "Must include a name"}
  validates :email, presence: {message: "Must have an email"}
  validates :mailing_address, presence: {message: "Must have a mailing address"}
  validates :cc_name, presence: {message: "Must have a credit card name"}
  validates :cc_expiration, presence: {message: "Must have an expiration date"}
  validates :cc_number, presence: {message: "Must have a credit card number"}
  validates_format_of :cc_number, :with => /\b\d{13,16}\b/
  validates :cc_ccv, presence: {message: "must include a ccv number"}
  validates_format_of :cc_ccv, :with => /\b\d{3}\b/
  validates :billing_zip, presence: {message: "Must include a billing zip code"}
end
