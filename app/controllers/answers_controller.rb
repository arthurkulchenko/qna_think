class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :answer_loader_and_authorship_verification, only: [:update, :destroy]

  def create
    @answer = Question.find(params[:question_id]).answers.new(answer_params)
    @answer.user = current_user
    respond_to do |format|
      if @answer.save
        format.js
        format.json { render json: @answer }
        # PrivatePub.publish_to("/questions/#{@answer.question_id}/answers", answer: @answer)
      else
        format.js
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @answers_with_filter = @answer.answers_stack.best_first.includes(:attachments)
    # @answer.update(answer_params)
    respond_to do |format|
      if @answer.update(answer_params)
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @answer.delete
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :best_answer, attachments_attributes: [file:[]])
  end

  def answer_loader_and_authorship_verification
    @answer = Answer.find(params[:id])
    redirect_to @answer.question, notice: "Deny!" unless current_user.is_author_of?(@answer)
  end

end