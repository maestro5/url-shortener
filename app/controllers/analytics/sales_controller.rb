class Analytics::SalesController < ApplicationController
  respond_to :html

  helper_method :sales, :filtering_params, :sort_column, :sort_direction

  def index
  end

  private

  def sales
    @sales ||=
      Analytics::Sale
        .with_transactions
        .filter(filtering_params)
        .paginate(page: params[:page], per_page: PER_PAGE)
        .order("#{sort_column} #{sort_direction}")
  end

  def filtering_params
    params.permit(:email, :last_name)
  end

  def sort_column
    (%w(first_name total_transactions total_amount average_amount average_period) & [params[:sort]]).first || 'first_name'
  end
end
