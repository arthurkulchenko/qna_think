class Authorization < ApplicationRecord
  belongs_to :user

  after_save :send_email

  def send_email
    EmailConfirmationMailer.verify_authorization(user, confirmation_token)
                                                .deliver_now unless is_confirmed
  end


end
