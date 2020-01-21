class Analytics::Sale < ApplicationRecord
  has_many :transactions

  validates :total_amount, :total_transactions,
            :average_amount, :average_period, presence: true

  scope :with_transactions, -> do
    joins(:transactions)
      .select('sales.*, transactions.first_name, transactions.last_name, transactions.email')
      .distinct
  end
end
