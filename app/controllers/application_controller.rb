class ApplicationController < ActionController::Base
  PER_PAGE = 10

  private

  def sort_direction
    (%w(asc desc) & [params[:direction]]).first || 'asc'
  end
end
