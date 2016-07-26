class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :question_load
  before_action :answer_load, :authorship_verification, only: [:update, :destroy]
  
  def index
    @answers = @question.answers
  end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    flash[:notice] = 'Your Answer deleted' if @answer.delete
  end

  private

  def authorship_verification
    redirect_to @question, notice: "You can't modify this Answer" unless @answer.user_id == current_user.id
  end

  def question_load
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content)
  end

  def answer_load
    @answer = @question.answers.find(params[:id])
  end

end