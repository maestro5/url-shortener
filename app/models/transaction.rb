class Transaction < ApplicationRecord
  validates :email, :first_name, :last_name, :amount, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :amount, numericality: { only_integer: true }
end
