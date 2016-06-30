class AnswerController < ApplicationController
  before_filter :question_load
  
  def index
    @answers = @question.answers
  end

  def new
  	@answer = @question.answers.new
  end

  def create
  	@answer = @question.answers.new(answer_params)
  	redirect_to question_index_path if @answer.save
  end

  def show
  	@answer = @question.answers.where(id: params[:id]).first
  end

  private

  def question_load
  	@question ||= Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content)
  end



end
