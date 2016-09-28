class UserController < ApplicationController
  def update
    @user = User.find(params[:id])
    @user.update(users_params)
    @path = @user.email[(@user.email.index('@')+1)..-1]
    redirect_to "http://#{@path}"
  end

  private

  def users_params
    params.require(:user).permit(:email)
  end

end
