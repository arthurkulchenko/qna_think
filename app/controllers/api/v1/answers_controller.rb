class Api::V1::AnswersController < Api::V1::BaseController
  def index
    @answers = Answer.all
    respond_with(@answer)
  end

  def new
    respond_with(@answer = Answer.new)	
  end

  def create
    respond_with(@answer = current_resource_owner.answers.create!(answer_params))
  end

  def show
    @answer = Answer.find(params[:id])
    respond_with(@answer)
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end