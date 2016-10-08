class VotesController < ApplicationController
  # authorize_resource
  before_action :authorship_verification, only: [:destroy]
  respond_to :json
  
  def create
    authorize! :vote, parent
    respond_with(@vote = parent.votes.create(vote_params.merge(user: current_user)))
  end

  def destroy
    authorize! :destroy, @vote
    respond_with(@vote.destroy)
  end

  private

  def authorship_verification
    @vote = Vote.find(params[:id])
    redirect_to @vote, notice: 'Deny!' unless current_user.is_author_of?(@vote)
  end

  def parent
    @parent ||= request.original_fullpath[/[\w]+/].classify.constantize.find(params["#{request.original_fullpath[/[\w]+/].singularize}".+('_id').to_sym])
  end

  def vote_params
    params.require(:vote).permit(:mark)
  end
end