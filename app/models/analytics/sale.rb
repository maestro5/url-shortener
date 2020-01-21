class Analytics::Sale < ApplicationRecord
  has_many :transactions

  validates :total_amount, :total_transactions,
            :average_amount, :average_period, presence: true
end
