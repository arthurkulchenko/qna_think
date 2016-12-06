class SearchingsController < ApplicationController
  skip_authorization_check
  def create
    respond_to do |format|
      format.json { render json: Search.for(params[:query], params[:area]) }
    end
  end

end