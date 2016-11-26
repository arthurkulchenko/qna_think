class QuestionsChannel < ApplicationCable::Channel

  def subscribed
  end

  def unsubscribed
  end

  def start_stream
    stream_from '/questions'
    # stream_from "/#{params[:controller]}"
  end

end