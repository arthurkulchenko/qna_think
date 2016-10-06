class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, # :confirmable, :lockable, :timeoutable
         :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]
  
  [:questions, :answers, :votes, :comments, :attachments, :authorizations].each do |model|
    has_many model, dependent: :destroy
  end

  def is_author_of?(obj)
    obj.user_id == id
  end
  
  def self.find_for_oauth(req)
    authorization = Authorization.where(provider: req.provider, uid: req.uid.to_s).first
    return authorization.user if authorization
    if req.info.has_key?(:email) && user = User.find_by(email: req.info[:email])
      user
    else
      password_generating
      email_genarating(req)
      user = User.create!(email: @g_email, password: @password, password_confirmation: @password, email_real: @r_email )
    end
    user.authorizations.create!(provider: req.provider, uid: req.uid.to_s) if user.authorizations.empty?
    user
  end

  private

  class << self

    def email_genarating(req)
      if req.info.has_key?(:email)
        @r_email = true
        @g_email = req.info[:email]
      else
        @r_email = false
        @g_email = "#{req.provider}-#{req.uid}@email.com"
      end
    end

    def password_generating
      @password = Devise.friendly_token[0..20]
    end

  end

  def merge_this(user)
    user.authorizations.each do |auth|
      auth.update(user_id: id)
    end
    user.destroy
    save
    self
  end
  
end