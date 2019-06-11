class LinksController < ApplicationController
  def index
  end

  def create
    creator = LinkCreator.(link_params)

    respond_to do |format|
      if creator.success?
        @internal_link = "#{request.base_url}/#{creator.internal_link}"

        format.js   { flash[:success] = ['The internal link has successfully created!'] }
        format.json { render json: { short_url: "/#{creator.internal_link}", url: creator.url }, status: :ok }
      else
        format.js   { flash[:error] = creator.errors }
        format.json { render json: creator.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  private

  def link_params
    params.permit(:url)
  end
end
