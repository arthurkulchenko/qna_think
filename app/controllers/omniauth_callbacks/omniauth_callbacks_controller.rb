class OmniauthCallbacks::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate, only: [:facebook, :twitter]
  
  def facebook
  end

  def twitter
  end

  def authenticate
    @req = request.env["omniauth.auth"]
    @user = User.find_for_oauth(@req)
    @authorization = @user.authorizations.where(provider: @req.provider, uid: @req.uid).first
    if @authorization.is_confirmed || @authorization.user.email_real
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :seccess, kind: @req.provider) if is_navigational_format?
    else
      if @user.email_real
        redirect_to root_path  
      else
        redirect_to edit_email_confirm_path(@authorization)
      end
      
    end
  end
end