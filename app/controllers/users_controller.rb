class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def show
  end

  def update
    current_user.update(user_params)
  end

  private

    def user_params
      params.require(:user).permit(:subscibe_on_digest)  	
    end
end
