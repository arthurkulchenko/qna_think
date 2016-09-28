class OmniauthCallbacks::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate, only: [:facebook, :twitter]
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
  
  def facebook
    # render json: request.env["omniauth.auth"]
  end

  def twitter
    # render json: request.env["omniauth.auth"]
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

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
