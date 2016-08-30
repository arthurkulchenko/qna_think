class VotesController < ApplicationController

  def create

    @object =
              if request.original_fullpath.match('questions')
                Question.find(params[:question_id])
              elsif request.original_fullpath.match('answers')
                Answer.find(params[:answer_id])   	
              end  
    @vote = @object.votes.new(vote_params)



    @vote.user = current_user
    respond_to do |format|
      if @vote.save #(user: current_user)
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
      # format.json { render json: @vote.ballot.reload }
      format.json { render :nothing => true }
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:mark)
  end
end
