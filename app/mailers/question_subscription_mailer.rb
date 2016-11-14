class QuestionSubscriptionMailer < ApplicationMailer
  def send_digest(users, questions)
    users.each do |user|
      mail(to: user.email, subject: 'QA_thinknetika Digest')
    end
  end

  def new_answer_letter(user, answer)
    mail(to: user.email, subject: 'You have new answer')	
  end
end
