class SubscribtionsController < ApplicationController
  include Parent
  before_action :authenticate_user!
  authorize_resource
  respond_to :json

  def create
    # @subscribtion = Subscribtion.new
    # @subscribtion.user = current_user
    # @subscribtion.save
    # respond_with @subscribtion
    respond_with @subscribtion = parent.subscribtions.create(user: current_user)
  end

  # private

  #   def parent
  #     @parent ||= request.original_fullpath[/[\w]+/].classify.constantize.find(params["#{request.original_fullpath[/[\w]+/].singularize}".+('_id').to_sym])
  #   end

end
