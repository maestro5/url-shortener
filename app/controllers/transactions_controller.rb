class TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  respond_to :json, :html

  helper_method :transactions, :filtering_params, :sort_column, :sort_direction

  def create
    transaction = TransactionCreator.call(transition_params).transaction

    respond_with(transaction, location: nil)
  end

  def index
  end

  private

  def transition_params
    params.permit(:email, :first_name, :last_name, :amount)
  end

  def transactions
    @transactions ||=
      Transaction
        .filter(filtering_params)
        .paginate(page: params[:page], per_page: PER_PAGE)
        .order("#{sort_column} #{sort_direction}")
  end

  def filtering_params
    params.permit(:email, :last_name)
  end

  def sort_column
    (%w(first_name amount created_at) & [params[:sort]]).first || 'first_name'
  end
end
