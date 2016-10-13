class Api::V1::ProfilesController < ApplicationController

  respond_to :json
  def me
    authorize! :me, current_resource_owner
    respond_with current_resource_owner
  end

  def index
    authorize! :profiles, current_resource_owner
    @users = User.where.not(id: current_resource_owner.id)
    respond_with @users
  end

  protected

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end