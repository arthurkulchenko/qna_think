class SetEmailsController < ApplicationController
  def edit
    @user = User.find(params[:id])  	
  end

  def update
    @user = User.find(params[:id])
    @token = SecureRandom.base64(18)
    EmailConfirmationMailer.please_confirm_email(@user, @token).deliver_now
    @user.update(email_confirmation_token: @token)
    @path = @user.email[(@user.email.index('@')+1)..-1]
    redirect_to @path
  end

  def show
    @user = User.find_by(email_confirmation_token: params[:id])
    @user.update_attributes(email_confirmed: true)
    sign_in_and_redirect @user, event: :authentication
  end

  private

  def user_email_params
    params.require(:user).permit(:email)
  end
end
