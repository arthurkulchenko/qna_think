class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
  skip_authorization_check only: [:index]
  load_resource only: [:show, :update, :destroy, :new]
  authorize_resource
  before_action :authorship_verification, only: [:update, :destroy]

  respond_to :js, only: [:create, :destroy, :update]

  def index
    respond_with(@questions = Question.all)
  end

  def new
    respond_with @question
  end

  def create
    @question = current_user.questions.create(question_params)
    if @question.errors.any?
      respond_with(@question)
    else
      ActionCable.server.broadcast '/questions',
                                    ApplicationController.render( partial: 'questions/new_question',
                                                                  locals: { question: @question} )
    end
  end

  def show
    @answers = @question.answers.best_first
    respond_with @question
  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    respond_with(@question.delete)
  end

  private

  def authorship_verification
    redirect_to @question, notice: 'Deny!' unless current_user.is_author_of?(@question)
  end

  def question_params
    params.require(:question).permit(:title, :content, attachments_attributes: [:id, :file, :_destroy])	
  end
end