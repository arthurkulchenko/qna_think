class AnswersController < ApplicationController
  before_action :authenticate_user!
  # skip_authorization_check :create
  authorize_resource except: [:create]
  before_action :authorship_verification, only: [:update, :destroy]
  respond_to :js, :json

  def create
    # authorize! :create Question
    @answer = Question.find(params[:question_id]).answers.create(answer_params.merge(user: current_user))
    ActionCable.server.broadcast "/question/#{@answer.question_id}/answers", @answer
    respond_with @answer
    # respond_with :api, :v1, @thing
  end

  def update
    @answer.update(answer_params)
    respond_with(@answer)
  end

  def destroy
    respond_with @answer.destroy do |format|
      format.js { render nothing: true }
      format.json { render head: :no_content }
    end
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