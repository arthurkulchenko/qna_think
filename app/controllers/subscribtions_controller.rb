class SubscribtionsController < ApplicationController
  include Parent
  before_action :authenticate_user!
  authorize_resource
  respond_to :json

  def create
    respond_with @subscribtion = parent.subscribtions.create(user: current_user)
  end

  def destroy
    @subscribtion = Subscribtion.find params[:id]
    respond_with @subscribtion.destroy
  end

end