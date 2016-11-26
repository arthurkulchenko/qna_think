class DigestLetteringJob < ApplicationJob
  queue_as :default

  def perform
    User.digest_subscribers.find_each do |user|
      QuestionSubscriptionMailer.send_digest(user, Question.last_24_hours.to_a).deliver_later
    end
  end
end
