class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :question_load
  before_action :answer_load, :authorship_verification, only: [:edit, :update, :destroy]
  
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

  def edit
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
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

  def answer_load
    @answer = @question.answers.find(params[:id])
  end

end