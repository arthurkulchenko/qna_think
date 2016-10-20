class QuestionsChannel < ApplicationCable::Channel

  def subscribed
  end

  def unsubscribed
  end

  def start_stream
    stream_from "/questions"
  end

end