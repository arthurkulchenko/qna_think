class AnswerController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :answer_load, only: [:show, :edit, :update, :delete]
  before_action :question_load
  
  def index
    @answers = @question.answers
  end

  def new
    # @question = Question.find(params[:id])
  	@answer = @question.answers.new
  end

  def create
  	@answer = @question.answers.new(answer_params)
    @answer.user = current_user
  	if @answer.save
      redirect_to question_path(@question), notice: 'Thank you for you Answer'
    else
      # redirect_to :back, notice: err_any?(@answer)
      render :new
    end
  end

  def show
  	# @answer = @question.answers.where(id: params[:id]).first
  end

  def destroy
    # @answer = @question.answers.where(id: params[:id]).first
    if @answer.delete
      redirect_to @question, notice: 'Your answer deleted'
    end
  end

  private

  def question_load
    if params[:action] == 'new' || 'index' || 'create'
      @params = params[:id]
    else
      @params = params[:question_id]
    end
  	@question = Question.find(@params)
  end

  def answer_params
    params.require(:answer).permit(:content)
  end

  def answer_load
    @answer = @question.answers.find(params[:id])
  end



end
