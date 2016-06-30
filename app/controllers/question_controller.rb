class QuestionController < ApplicationController
  def index
  	@questions = Question.all
  end

  def new
  	@question = Question.new
  end

  def create
  	@question = Question.new(question_params)
  	redirect_to question_path(@question) if @question.save
  end

  def show
    @question = Question.find(params[:id])
  end

  private
  def question_params
    params.require(:question).permit(:title, :content)	
  end
  
end
