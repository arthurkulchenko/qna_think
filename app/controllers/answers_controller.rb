class AnswersController < ApplicationController
  before_action :authenticate_user!
  # skip_authorization_check :create
  authorize_resource except: [:create]
  before_action :authorship_verification, only: [:update, :destroy]
  respond_to :js

  def create
    # authorize! :create Question
    @answer = Question.find(params[:question_id]).answers.create(answer_params.merge(user: current_user))
    # respond_with @answer
    respond_to do |format|
      format.json { ActionCable.server.broadcast "/question/#{@answer.question_id}/answers", @answer
                    render nothing: true
                  }
    end
  end

  def update
    @answer.update(answer_params)
    respond_with(@answer)
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { render nothing: true }
    end
    # respond_with(@answer.destroy)
  end

  private

  def authorship_verification
    @answer ||= Answer.find(params[:id])
    redirect_to @answer.question, notice: 'Deny!' unless current_user.is_author_of?(@answer)
  end

  def answer_params
    params.require(:answer).permit(:content, :best_answer, attachments_attributes: [file:[]])
  end
end