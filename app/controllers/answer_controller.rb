class AnswerController < ApplicationController
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
  	if @answer.save
      redirect_to questions_path(@question), notice: 'Thank you for you Answer'
    else
      render :new
    end
  end

  def show
  end

  def destroy
    if @answer.delete
      redirect_to @question, notice: 'Your answer deleted'
    end
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