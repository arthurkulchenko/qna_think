# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class AnswersCommentsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def start_stream
    stream_from "/question/#{params[:question]}/answers/comments"
  end
end
