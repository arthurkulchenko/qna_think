class VotesController < ApplicationController
  include Parent
  before_action :authorship_verification, only: [:destroy]
  respond_to :json
  
  def create
    authorize! :vote, parent
    respond_with @vote = parent.votes.create(vote_params.merge(user: current_user))
  end

  def destroy
    authorize! :destroy, @vote
    respond_with @vote.delete 
  end

  private

  def authorship_verification
    @vote = Vote.find(params[:id])
    redirect_to @vote, notice: 'Deny!' unless current_user.is_author_of?(@vote)
  end

  def vote_params
    params.require(:vote).permit(:mark)
  end
end