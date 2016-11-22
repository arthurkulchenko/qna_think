class NewAnswerLetteringJob < ApplicationJob
  queue_as :default

  def perform(answer)
    Subscribtion.where(subscribtable: answer.question).find_each do |subscribtion|
      QuestionSubscriptionMailer.new_answer_letter(subscribtion.user, answer).deliver_later
    end
  end
end
