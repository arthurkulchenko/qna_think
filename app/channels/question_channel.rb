# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class QuestionChannel < ApplicationCable::Channel
  def subscribed
    # alert 'it\'s mast\'nt subscribe'
    # stream_from "/question_#{current_question.id}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def new_question(data)
    # ActionCable.server.broadcast 'questions_channel', message: data['message']    
  end

  def current_question
    
  end
end
