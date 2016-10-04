class EmailConfirmationMailer < ApplicationMailer
	
  def verify_authorization(user, token)
    @link = authorization_url(token)
    mail(to: user.email, subject: 'Email Confirmation')	
  end
end