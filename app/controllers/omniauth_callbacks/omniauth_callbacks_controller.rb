class OmniauthCallbacks::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate, only: [:facebook, :twitter]
  
  def facebook
  end

  def twitter
  end

  def authenticate
    @req = request.env["omniauth.auth"]
    @user = User.find_for_oauth(@req)
    if @user.email_confirmed
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :seccess, kind: @req.provider) if is_navigational_format?
    else
      redirect_to edit_set_email_path(@user.id)
    end
  end
end
