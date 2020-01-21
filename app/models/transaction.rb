class Transaction < ApplicationRecord
  belongs_to :sale, class_name: 'Analytics::Sale'

  validates :email, :first_name, :last_name, :amount, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :amount, numericality: { only_integer: true }

  scope :email,     -> (email)     { where(email: email) }
  scope :last_name, -> (last_name) { where(last_name: last_name) }
end
