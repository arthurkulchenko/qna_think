class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :question_load
  before_action :answer_load, only: [:show, :edit, :update, :destroy]
  
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

  def show
  end

  def destroy
    return redirect_to @question unless @answer.user_id == current_user.id
    return redirect_to @question unless @answer.delete
      redirect_to @question, notice: 'Your answer deleted'
  end

  private

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