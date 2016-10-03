class SetEmailsController < ApplicationController
  before_action :user_load, except: [:show]

  def edit	
  end

  def update
    @token = SecureRandom.base64(18)
    @user_by_email = User.find_by(email:params[:user][:email])

    unless @user_by_email
      @user.update!(users_params.merge(email_confirmation_token: @token))
    else
      @user = @user_by_email.merge_user_in(@user)
    end

    # if @user_by_email && @user_by_email == params[:user][:email]
    #   @user = @user_by_email.merge_user_in(@user) # объединяем пользователей, 
    #                          #если раньше пользовался приложением, а потом зашел через фб
    # else
    #   @user.update!(users_params.merge(email_confirmation_token: @token))
    #   @user.set_token
    # end
    EmailConfirmationMailer.please_confirm_email(@user, @user.email_confirmation_token).deliver_now
    @path = @user.email[(@user.email.index('@')+1)..-1]
    redirect_to "http://#{@path}"
  end

  def show
    @user = User.find_by(email_confirmation_token: params[:id])
    @user.update_attributes(email_confirmed: true, email_confirmation_token: nil)
    sign_in_and_redirect @user, event: :authentication
  end

  private

  def user_load
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:email)
  end
end