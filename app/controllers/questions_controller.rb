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
    respond_to do |format|
      if @question.save
        format.js { redirect_to question_path(@question), notice: 'Please wait for a while,' \
                                                  ' someone will answer you soon.'  }
      else
        format.html { render :new }
      end
    end
    # if @question.save
    #   redirect_to question_path(@question), notice: 'Please wait for a while,' \
    #                                              ' someone will answer you soon.' 
    # else
    #   render :new
    # end
  end

  def show
    @one_best_answer = @question.answers.best_first.first
  end

  def update
    @question.update(question_params)
  end

  def destroy
    redirect_to questions_path, notice: 'Your Question is deleted' if @question.delete
  end

  private
  
  def authorship_verification
    redirect_to @question, notice: "You can't modify this Question" unless current_user.is_author_of?(@question)
  end

  def question_params
    params.require(:question).permit(:title, :content, attachments_attributes: [file:[]])	
  end

  def question_load
    @question = Question.find(params[:id])
  end
  
end
