require 'rails_helper'

RSpec.describe Analytics::SalesCalculator do
  let(:email) { 'test@example.com' }
  let(:sale) { instance_spy(Analytics::Sale, transactions: [], errors: []) }

  subject { described_class.call(sale) }

  before { allow(sale).to receive(:transactions) { transactions } }

  context 'when does not have transactions' do
    let(:transactions) { [] }
    let(:error) { 'Does not have transactions' }

    it 'does not create a sale' do
      expect { subject }.not_to change(Analytics::Sale, :count)
    end

    it 'contains an error' do
      expect(subject.errors).to include(error)
    end
  end

  context 'with transactions' do
    let(:transaction_one) { double(:transaction_1, amount: 7, created_at: 11.days.ago) }
    let(:transaction_two) { double(:stransaction_2, amount: 4, created_at: 4.days.ago) }
    let(:transaction_three) { double(:transaction_3, amount: 6, created_at: 1.day.ago) }
    let(:average_period) { 5 }

    let(:transactions_total_amount) { transactions.sum(&:amount) }
    let(:average_amount) { transactions_total_amount / transactions.size }
    let(:transactions) { [transaction_one, transaction_two, transaction_three] }

    it 'calculates the sale' do
      expect(sale).to receive(:update_attributes).with(
        total_amount:       transactions_total_amount,
        total_transactions: transactions.size,
        average_amount:     average_amount,
        average_period:     average_period
      ) { true }

      described_class.call(sale)
    end
  end
end
