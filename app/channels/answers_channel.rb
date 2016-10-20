class AnswersChannel < ApplicationCable::Channel

  def subscribed
  end

  def unsubscribed
  end

  def start_stream_answers(question_id)
    stream_from "/question/#{question_id}/answers"
  end

end