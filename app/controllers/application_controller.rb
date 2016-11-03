require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  
  # protect_from_forgery unless: -> { request.format.json? }
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
      format.js { render partial: 'layouts/exception', status: :forbidden }
      format.json { render json: exception.message, status: :unauthorized }
    end
  end

  # check_authorization :unless => :devise_controller?

end