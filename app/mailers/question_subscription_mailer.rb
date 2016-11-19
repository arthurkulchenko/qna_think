class QuestionSubscriptionMailer < ApplicationMailer
  def send_digest(user, questions)
    @user = user
    @questions = questions
    mail(to: user.email, subject: 'QA_thinknetika_app Digest.')
  end

  def new_answer_letter(user, answer)
    @user = user
    @answer = answer
    mail(to: user.email, subject: 'New answer on question you are interested.')
  end

  def question_changings_lettering(user, question)
    @user = user
    @question = question
    mail(to: user.email, subject: 'Question was updated.')	
  end
end
