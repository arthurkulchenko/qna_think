class Api::V1::AnswersController < Api::V1::BaseController
  load_and_authorize_resource except: [:create]

  def index
    respond_with(@answers)
  end

  def new
    respond_with(@answer = Answer.new)	
  end

  def create
    respond_with(
      @answer = current_resource_owner
                 .answers.create!(
                                   answer_params
                                      .merge(question_id: params[:question_id].to_i)
                                  )
                 )
  end

  def show
    respond_with @answer
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end