class AuthorizationsController < ApplicationController
  skip_authorization_check

  def show
    # EXPLANATION of updating authorization
    # It's page appears after clicking on link in e-mail
    #   wich is recived by user who has provide real e-mail.
    @auth = Authorization.find_by(confirmation_token: params[:id])
    if @auth.update(is_confirmed: true, confirmation_token: nil)
      sign_in_and_redirect @auth.user, event: :authentication
    else
      redirect_to root_path, notice: "Something went wrong"
    end
  end
end