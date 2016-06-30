class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def err_any?(object)
    if object.errors.any?
      @err_s = object.errors.full_messages.map { |i| i }
      flash.now[:errors] = @err_s.to_s[1..-2]
    end
  end
end
