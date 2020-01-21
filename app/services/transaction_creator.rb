class TransactionCreator
  attr_reader :transaction, :sale

  delegate :errors, :email, to: :transaction

  def self.call(*args)
    new(*args).tap(&:perform)
  end

  def initialize(params)
    @transaction = Transaction.new(params)
  end

  def perform
    Transaction.transaction do
      save_transaction && calculate_sales
    end
  end

  private

  def save_transaction
    transaction.sale = sale
    transaction.email.downcase!

    transaction.save
  end

  def sale
    @sale ||=
      Transaction.find_by(email: email)&.sale || Analytics::Sale.create
  end

  def calculate_sales
    Analytics::SalesCalculator.call(sale)
  end
end
