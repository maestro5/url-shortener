class Analytics::SalesController < ApplicationController
  PER_PAGE = 10

  respond_to :html

  helper_method :sales, :sort_column, :sort_direction

  def index
  end

  private

  def sales
    @sales ||=
      Analytics::Sale
        .with_transactions
        .paginate(page: params[:page], per_page: PER_PAGE)
        .order("#{sort_column} #{sort_direction}")
  end

  def sort_column
    (%w(first_name total_transactions total_amount average_amount average_period) & [params[:sort]]).first || 'first_name'
  end

  def sort_direction
    (%w(asc desc) & [params[:direction]]).first || 'asc'
  end
end
