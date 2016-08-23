class VotesController < ApplicationController

  def create

    # case @object
    # when params[:commit] == 'Rate Question'
    #   Question.find(params[:question_id])
    # when params[:commit] == 'Rate Answer'
    #   Answer.find(params[:answer_id])   	
    # end

    @object =
              if params[:commit] == 'Rate Question'
                Question.find(params[:question_id])
              elsif params[:commit] == 'Rate Answer'
                Answer.find(params[:answer_id])   	
              end


    # @question = Question.find(params[:question_id])
    # @answer = Answer.find(params[:answer_id])

    # @object = @answer || @question

    @vote = @object.votes.new(vote_params)
    @existed_vote = current_user.votes.where(ballot: @object.id).first
    @existed_vote.delete if @existed_vote

    @vote.user = current_user
    respond_to do |format|
      if @vote.save
        format.json { render json: @vote }
      else
        format.json { render json: @vote.errors.full_messages, status: :unprocessable_entity }
      end
    end  	
  end

  def destroy
    @vote = Vote.find(params[:id])
    @object = @vote.ballot_type.constantize.find(@vote.ballot_id)
    if current_user.is_author_of?(@vote)
      @object.update(mark: @object.votes.pluck(:mark).sum) if @vote.delete
      respond_to do |format|
        format.json { render json: 'You tack back your voice' }
      end
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:mark)
  end
end
