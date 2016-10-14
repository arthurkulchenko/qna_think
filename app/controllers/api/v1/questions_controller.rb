class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :doorkeeper_authorize!

  def index
    @questions = Question.all
    respond_with @questions
  end

  def show
    @question = Question.find(params[:id])
    respond_with @question
  end

  def new
    @question = Question.new
    respond_with @question
  end

  def create
    respond_with(@question = current_resource_owner.questions.create!(question_params))
  end

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
# fb895e4400d5c5f61fe88e05d394c7cbf5453883cf96eec4a2c2dfa63cef0abf
# http://localhost:3000/api/v1/questions.json?access_token=fb895e4400d5c5f61fe88e05d394c7cbf5453883cf96eec4a2c2dfa63cef0abf&question[title]=Hello&question[content]=new contnet