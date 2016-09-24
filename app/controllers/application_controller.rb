require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  before_action :authorship_verification, only: [:update, :destroy]

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  
  def authorship_verification
    @this = params[:controller].classify.constantize.find(params[:id])
    redirect_to @this, notice: 'Deny!' unless current_user.is_author_of?(@this)
  end
end