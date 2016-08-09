class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :question_load, only: [:create]
  before_action :special_loader_for_shallow_routes, only: [:update, :delete]
  before_action :authorship_verification, only: [:update, :delete]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @answer.delete
  end

  private

  def authorship_verification
    redirect_to @question, notice: "You can't modify this Answer" unless current_user.is_author_of?(@answer)
  end

  def question_load
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content, :best_answer)
  end

  def special_loader_for_shallow_routes
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end


end