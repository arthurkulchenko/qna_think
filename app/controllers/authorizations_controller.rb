class AuthorizationsController < ApplicationController

  def show
    @auth = Authorization.find_by(confirmation_token: params[:id])
    @auth.update!(is_confirmed: true, confirmation_token: nil)
    sign_in_and_redirect @auth.user, event: :authentication
  end
end