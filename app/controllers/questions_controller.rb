class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
  skip_authorization_check only: [:index]
  load_resource only: [:show, :update, :destroy, :new]
  authorize_resource
  before_action :authorship_verification, only: [:update, :destroy]

  respond_to :json, only: [:create, :destroy]

  def index
    respond_with(@questions = Question.all)
  end

  def new
    respond_with @question
  end

  def create
    # respond_with :api, :v1, @thing
    @question = current_user.questions.create(question_params)
    respond_with @question do |format|
      if @question.errors.any?
        format.js { render json: @question.errors.full_messages, status: 422 }
        format.json { render json: @question.errors.full_messages, status: 422 }
      else
        format.js { render nothing: true }
        format.json { render json: @question }
      end
    end
  end

  def show
    gon.current_user = current_user if current_user
    @answers = @question.answers.best_first
    respond_with @question
  end

  def update
    @question.update(question_params)
    respond_with @question do |format|
      format.js { render nothing: true }
      format.json { render json: @question }
    end
    # respond_with @question
  end

  def destroy
    respond_with @question.destroy do |format|
      format.js { render nothing: true }
      format.json { render nothing: true }
    end
  end

  private

  def authorship_verification
    redirect_to @question, notice: 'Deny!' unless current_user.is_author_of?(@question)
  end

  def question_params
    params.require(:question).permit(:title, :content, attachments_attributes: [:id, :file, :_destroy]) 
  end

end