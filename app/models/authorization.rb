class Authorization < ApplicationRecord
  include BelongingsOfUser

  before_save :set_token
  after_save :send_email

  private

  def send_email
    EmailConfirmationMailer.verify_authorization(user, confirmation_token)
                                                .deliver_now unless is_confirmed
  end

  def set_token
    self.confirmation_token = SecureRandom.base64(18).delete('/') unless is_confirmed 
  end

end