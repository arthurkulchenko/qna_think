class QuestionController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
  	@questions = Question.all
  end

  def new
  	@question = Question.new
  end

  def create
  	@question = Question.new(question_params)
  	if @question.save
      redirect_to question_path(@question), notice: 'Please wait for a while,' \
                                                 ' someone will answer you soon.' 
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    redirect_to question_index_path if @question.destroy
  end

  private
  def question_params
    params.require(:question).permit(:title, :content)	
  end
  
end
