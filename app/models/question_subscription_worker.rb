class QuestionSubscriptionWorker
  include Sidekiq::Worker
  include Sidekiq::Shedulable

  recurrence { daily(1) }

  def perform
    User.sending_digest_newsletter	
  end
end