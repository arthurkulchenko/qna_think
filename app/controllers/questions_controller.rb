class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :question_load, only: [:show, :edit, :update, :destroy]
  before_action :authorship_verification, only: [:destroy]
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
      redirect_to question_path(@question), notice: 'Please wait for a while,' \
                                                 ' someone will answer you soon.' 
    else
      render :new
    end
  end

  def show
  end

  def destroy
    redirect_to questions_path, notice: 'Your Question is deleted' if @question.delete
    # return redirect_to @question unless @question.user_id == current_user.id
    # return redirect_to @question unless @question.delete
    #   redirect_to questions_path
  end

  private
  
  def authorship_verification
    redirect_to @question, notice: "You can't delete this Question" unless @question.user_id == current_user.id
  end

  def question_params
    params.require(:question).permit(:title, :content)	
  end

  def question_load
    @question = Question.find(params[:id])
  end
  
end
