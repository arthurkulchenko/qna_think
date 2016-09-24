class VotesController < ApplicationController

  def create
    @vote = parent.votes.new(vote_params)
    @vote.user = current_user
    respond_to do |format|
      if @vote.save
        format.json { render json: parent.reload }
      else
        format.json { render json: @vote.errors.full_messages, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy if current_user.is_author_of?(@vote)
    respond_to do |format|
      format.json { render :nothing => true }
    end
  end

  private

  def parent
    @parent ||= request.original_fullpath[/[\w]+/].classify.constantize.find(params["#{request.original_fullpath[/[\w]+/].singularize}".+('_id').to_sym])
  end

  def vote_params
    params.require(:vote).permit(:mark)
  end
end