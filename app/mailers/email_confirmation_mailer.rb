class EmailConfirmationMailer < ApplicationMailer
  def please_confirm_email(user, token)
    @this = set_email_url(token)
    mail(to: user.email, subject: 'Email Confirmation')
  end
end
