class EmailConfirmsController < ApplicationController
  skip_authorization_check
  
  def edit
    @auth = Authorization.find(params[:id])
    @user = @auth.user
    # @auth.update(name: "Updating...")
  end

  def update
    if @user = User.find_by(email: params[:user][:email])
      # если найден пользователь с имейлом запрос на слияние
    else
      # # не подтвержденных авторизаций может быть несколько
      # @auth = Authorization.find(params[:id])
      # @auth.name = "#{@auth.provider} email updating"
      # @auth.save
      # # если нет, то просто письмо для подтверждения почты
    end
    redirect_to root_path, notice: "Check Your E-mail please!"
  end
end
