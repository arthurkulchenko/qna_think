class AnswerController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :question_load
  
  def index
    @answers = @question.answers
  end

  def new
  	@answer = @question.answers.new
  end

  def create
  	@answer = @question.answers.new(answer_params)
  	if @answer.save
      redirect_to question_path(@question), notice: 'Thank you for you Answer'
    else
      # redirect_to :back, notice: err_any?(@answer)
      render :new
    end
  end

  def show
  	@answer = @question.answers.where(id: params[:id]).first
  end

  private

  def question_load
  	@question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content)
  end



end
