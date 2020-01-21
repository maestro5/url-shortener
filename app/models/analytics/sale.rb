class Analytics::Sale < ApplicationRecord
  include Filterable

  has_many :transactions

  validates :total_amount, :total_transactions,
            :average_amount, :average_period, presence: true

  scope :with_transactions, -> do
    joins(:transactions)
      .select('sales.*, transactions.first_name, transactions.last_name, transactions.email')
      .distinct
  end

  scope :email,     -> (email)     { merge Transaction.email(email) }
  scope :last_name, -> (last_name) { merge Transaction.last_name(last_name) }
end
