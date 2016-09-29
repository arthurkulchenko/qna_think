class SetEmailsController < ApplicationController
  def edit
    @user = User.find(params[:id])  	
  end

  def update
    @user = User.find(params[:id])
    @token = SecureRandom.base64(18)
    @user.update(users_params.merge(email_confirmation_token: @token))
    EmailConfirmationMailer.please_confirm_email(@user, @token).deliver_now
    @path = @user.email[(@user.email.index('@')+1)..-1]
    redirect_to "http://#{@path}"
  end

  def show
    @user = User.find_by(email_confirmation_token: params[:id])
    @user.update_attributes(email_confirmed: true, email_confirmation_token: nil)
    sign_in_and_redirect @user, event: :authentication
  end

  private

  def users_params
    params.require(:user).permit(:email)
  end
end