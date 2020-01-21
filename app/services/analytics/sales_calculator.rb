class Analytics::SalesCalculator
  attr_reader :sale

  delegate :errors, :transactions, to: :sale

  def self.call(*args)
    new(*args).tap(&:perform)
  end

  def initialize(sale)
    @sale = sale
  end

  def perform
    errors << 'Does not have transactions' and return if transactions.empty?

    sale.update_attributes(
      total_amount:       total_amount,
      total_transactions: transactions.size,
      average_amount:     total_amount / transactions.size,
      average_period:     average_period
    )
  end

  private

  def total_amount
    @total_amount ||= transactions.map(&:amount).sum
  end

  def average_period
    return 0 if periods_between_transactions.empty?

    days(periods_between_transactions.sum / periods_between_transactions.size)
  end

  def periods_between_transactions
    @periods_between_transactions ||=
      transactions.each_cons(2).map { |a, b| b.created_at.to_i - a.created_at.to_i }
  end

  def days(seconds)
    seconds / 1.day.to_i
  end
end
