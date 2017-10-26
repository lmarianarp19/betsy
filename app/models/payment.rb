class Payment < ApplicationRecord
  has_one :order

  validates :name, presence: {message: "Must include a name"}
  validates :email, presence: {message: "Must have an email"}
  validates :mailing_address, presence: {message: "Must have a mailing address"}
  validates :cc_name, presence: {message: "Must have a credit card name"}
  validates :cc_expiration, presence: {message: "Must have an expiration date"}
  validate :expiration_date_cannot_be_in_the_past
  validates :cc_number, presence: {message: "Must have a credit card number"}
  validates :cc_number, format: { with: /\b\d{13,16}\b/, message: "Enter a valid credit card number" }
  validates :cc_ccv, presence: {message: "Must include a ccv number"}
  validates :cc_ccv, format: {with: /\b\d{3}\b/, message: "Must enter a valid CCV"}
  validates :billing_zip, presence: {message: "Must include a billing zip code"}

  def expiration_date_cannot_be_in_the_past
    if cc_expiration.present? && cc_expiration < Date.today
      errors.add(:cc_expiration, "Expiration date can't be in the past")
    end
  end
end
