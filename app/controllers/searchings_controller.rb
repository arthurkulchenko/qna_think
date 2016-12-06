class SearchingsController < ApplicationController
  skip_authorization_check
  respond_to :json
  def create
    respond_to do |format|
      format.json { render json: Search.for(params[:query], params[:area]) }
    end
  end

end