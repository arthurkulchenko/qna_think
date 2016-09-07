class VotesController < ApplicationController

  def create
    parent_object
    @vote = @object.votes.new(vote_params)
    @vote.user = current_user
    
    respond_to do |format|
      if @vote.save
        format.json { render json: @object.reload }
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

  def parent_object
    @obj = request.original_fullpath[/[\w]+/]
    @object = @obj.classify.constantize.find(params["#{@obj.singularize}".+('_id').to_sym])
  end

  def vote_params
    params.require(:vote).permit(:mark)
  end
end