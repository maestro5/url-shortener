class Analytics::SalesController < ApplicationController
  PER_PAGE = 10

  respond_to :html

  helper_method :sales

  def index
  end

  private

  def sales
    @sales ||=
      Analytics::Sale
        .with_transactions
        .paginate(page: params[:page], per_page: PER_PAGE)
  end
end
