class UsersController < ApplicationController

  def update
    @user = User.find(params[:id])
    if @user_by_email = User.find_by(email:params[:user][:email])
      @user = @user_by_email.merge_this(@user)
    else
      @user.update!(users_params)
    end
    redirect_to root_path, notice: "check your email please"
  end

  private

  def users_params
    parmas.require(:user).permit(:email)
  end
end