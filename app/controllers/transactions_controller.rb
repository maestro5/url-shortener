class TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  respond_to :json

  def create
    transaction = Transaction.create(transition_params)

    respond_with(transaction, location: nil)
  end

  private

  def transition_params
    params.permit(:email, :first_name, :last_name, :amount)
  end
end