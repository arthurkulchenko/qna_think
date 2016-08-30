class VotesController < ApplicationController
  respond_to :json

  def create
    @obj = request.original_fullpath[/[\w]+/]
    @object = @obj.classify.constantize.find(params[@obj.singularize.insert(-1,'_id').to_sym])
    @vote = @object.votes.new(vote_params)

    if @vote.save(user: current_user)
      respond_with( render json: @object.reload )
    else
      respond_with( render json: @vote.errors.full_messages, status: :unprocessable_entity )
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy if current_user.is_author_of?(@vote)
    respond_with( render :nothing => true )
  end

  private

  def vote_params
    params.require(:vote).permit(:mark)
  end
end