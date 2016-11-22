class QuestionChangingsJob < ApplicationJob
  queue_as :default

  def perform(question)
    Subscribtion.where(subscribtable: question).find_each do |subscribtion|
      unless subscribtion.user.is_author_of?(question)
        QuestionSubscriptionMailer.question_changings_lettering(subscribtion.user, question).deliver_later
      end
    end
  end
end
