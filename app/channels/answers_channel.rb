class AnswersChannel < ApplicationCable::Channel

  def subscribed
    # stream_from params[:controller] # Rails.logger # data['question_id']
    # question = Answer.find(params[:id])
    # stream_from "/question/#{params[:question]}/answers"
  end

  def unsubscribed
  end

  def start_stream_answers(data)
    stream_from "/question/#{params[:question]}/answers"
    # stream_from "/question/#{data['question_id']}/answers"
  end

end