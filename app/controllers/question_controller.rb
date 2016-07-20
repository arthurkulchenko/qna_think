class QuestionController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :question_load, only: [:show, :edit, :update, :destroy]
  def index
  	@questions = Question.all
  end

  def new
  	@question = Question.new
  end

  def create
  	@question = Question.new(question_params)
    @question.user = current_user
  	if @question.save
      redirect_to questions_path(@question), notice: 'Please wait for a while,' \
                                                 ' someone will answer you soon.' 
    else
      render :new
    end
  end

  def show
  end

  def destroy
    redirect_to question_index_path if @question.destroy
  end

  private
  def question_params
    params.require(:question).permit(:title, :content)	
  end

  def question_load
    @question = Question.find(params[:id])
  end
  
end
