require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception # For APIs, use :null_session

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
      format.js { render 'layouts/exception' }
      format.json { render json: exception.message, status: :unprocessable_entity }
    end
  end

  check_authorization :unless => :devise_controller?

end