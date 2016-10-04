class AuthorizationsController < ApplicationController

  def show
    @auth = Authorization.find_by(confirmation_token: params[:id])
    if @auth.update(is_confirmed: true, confirmation_token: nil)
      sign_in_and_redirect @auth.user, event: :authentication
    else
      redirect_to root_path, notice: "Something go wrong"
    end
  end
end