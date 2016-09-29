class SetEmailsController < ApplicationController
  def edit
    @user = User.find(params[:id])  	
  end

  def update
    @token = SecureRandom.base64(18)
    @user = User.find(params[:id])
    @user_by_email = User.find_by(email:params[:user][:email])
    if @user.email != params[:user][:email]
      if @user_by_email
        @user_by_email.merge_user(@user)
        @user = @user_by_email
        EmailConfirmationMailer.please_confirm_email(@user, @token).deliver_now
      else
        @user.update!(users_params.merge(email_confirmation_token: @token))
        EmailConfirmationMailer.please_confirm_email(@user, @token).deliver_now
      end
    else
      @user_by_email.merge_user(@user)
      @user = @user_by_email
      EmailConfirmationMailer.please_confirm_email(@user, user.token).deliver_now
    end
    # @user.update_attributes(email_confirmation_token: @token)
    # @user.update!(users_params) #.merge(email_confirmation_token: @token)
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