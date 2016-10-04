class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, # :confirmable, :lockable, :timeoutable
         :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]
  
  [:questions, :answers, :votes, :comments, :attachments, :authorizations].each do |model|
    has_many model, dependent: :destroy
  end

  # after_update :checking_email

  # def checking_email
  #   token = SecureRandom.base64(18)
  #   EmailConfirmationMailer.please_confirm_email(self, token).deliver_now
  #   if email_real

  #   end
  # end

  def is_author_of?(obj)
    obj.user_id == id
  end

  def merge_this(user)
    user.authorizations.each do |auth|
      new_attr = auth.attributes
      new_attr.delete("id")
      authorizations.create!(new_attr)
    end
    user.destroy
    save
    self
  end

  def self.find_by_auth(req)
    authorization = Authorization.where(provider: req.provider, uid: req.uid.to_s).first
    authorization.user if authorization
  end

  def self.find_by_email(req)
    token = SecureRandom.base64(18)
    user = User.find_by(email: req.info[:email]) if req.info.has_key?(:email)
    if user && user.authorizations.empty?
      user.authorizations.create!(provider: req.provider, uid: req.uid.to_s, confirmation_token: token)
    end
    user
  end

  def self.creating_new(req)
    password = Devise.friendly_token[0..20]
    token = SecureRandom.base64(18)
    if req.info.has_key?(:email)
      r_email = true
      g_email = req.info[:email]
    else
      r_email = false
      g_email = "#{req.provider}-#{req.uid}@email.com"
    end
    user = User.create!(email: g_email, password: password, password_confirmation: password, email_real: r_email )
    user.authorizations.create!(provider: req.provider, uid: req.uid.to_s, confirmation_token: token)
    user
  end

  def self.find_for_oauth(req)
    if User.find_by_auth(req)
      User.find_by_auth(req)
    elsif User.find_by_email(req)
        User.find_by_email(req)
      else
        User.creating_new(req)
      # end
    end
  end
end