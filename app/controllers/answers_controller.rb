class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :answer_loader_and_authorship_verification, only: [:update, :destroy]
  
  respond_to :js

  def create
    respond_with(@answer = Question.find(params[:question_id]).answers.create(answer_params.merge(user: current_user)))
  end

  def update
    @answer.update(answer_params)
    respond_with(@answer)
  end

  def destroy
    respond_with(@answer.delete)
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :best_answer, attachments_attributes: [file:[]])
  end

  def answer_loader_and_authorship_verification
    @answer ||= Answer.find(params[:id])
    redirect_to @answer.question, notice: 'Deny!' unless current_user.is_author_of?(@answer)
  end

end