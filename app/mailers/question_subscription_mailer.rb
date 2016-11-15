class QuestionSubscriptionMailer < ApplicationMailer
  def send_digest(user, questions)
    @user = user
    @questions = questions
    mail(to: user.email, subject: 'QA_thinknetika Digest')
  end

  def new_answer_letter(user, answer)
    @user = user
    @answer = answer
    mail(to: user.email, subject: 'You have new answer')
  end

  def question_newslettering(user, question)
    @user = user
    @question = question
    mail(to: user.email, subject: 'You have new answer')	
  end
end
