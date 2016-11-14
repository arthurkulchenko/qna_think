class QuestionSubscriptionMailer < ApplicationMailer
  def send_digest(user, questions)
    mail(to: user.email, subject: 'QA_thinknetika Digest')
  end

  def new_answer_letter(user, answer)
    mail(to: user.email, subject: 'You have new answer')
  end

  def question_newslettering(user, question)
    mail(to: user.email, subject: 'You have new answer')	
  end
end
