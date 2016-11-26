class EmailConfirmsController < ApplicationController
  skip_authorization_check
  
  def edit
    @auth = Authorization.find params[:id]
    @user = @auth.user
  end

  def update
    @auth = Authorization.find params[:id]
    if @user = User.find_by(email: params[:user][:email])
      @user.merge_into_old(@auth.user) #, after email confirmation
      # если найден пользователь с имейлом запрос на слияние
    else
      # Если не найден пользователь по email, но авторизация существует,
      # то нужно запросить проверку имейла, если имейл верен, то изменить пользователя
      # Но есть возможность украсть аккаунт, если подставить чужой имейл -
      # НУЖНО ПОСЛАТЬ ЛОГ АУТ В РП ЭТОГО ПОЛЬЗОВАТЕЛЯ ПЕРЕД ОТПРАВКОЙ ПРОВЕРОЧНОГО ПИСЬМА
      # а после направить на рп для логина и после свежего логина отправить письмо
    end
    redirect_to root_path, notice: "Check Your E-mail please!"
  end
end
