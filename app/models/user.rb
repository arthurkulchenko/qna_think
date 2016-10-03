class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, # :confirmable, :lockable, :timeoutable
         :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]
  
  [:questions, :answers, :votes, :comments, :attachments, :authorizations].each do |model|
    has_many model, dependent: :destroy
  end

  before_update :set_token

  def is_author_of?(obj)
    obj.user_id == id
  end

  def set_token
    email_confirmation_token = SecureRandom.base64(18)
  end

  def merge_user_in(user)
    user.authorizations.each do |auth|
      new_attr = auth.attributes
      new_attr.delete("id")
      authorizations.create!(new_attr)
    end
    
    user.destroy
    email_confirmation_token = SecureRandom.base64(18)
    save
    self
  end

  def self.find_by_auth(req)
    authorization = Authorization.where(provider: req.provider, uid: req.uid.to_s).first
    if authorization
      authorization.user
    else
      # User.find_by_email(req)
    end
  end

  def self.find_by_email(req)
    user = User.find_by(email: req.info[:email]) if req.info
    if user && user.authorizations == nil
      Authorization.create!(provider: req.provider, uid: req.uid, user: user)
    end
    user
  end

  def self.creating_new(req)
    password = Devise.friendly_token[0..20]
    g_email = "#{req.provider}-#{req.uid}@email.com"
    new_user = User.create!(email: g_email, password: password, password_confirmation: password )
    Authorization.create!(provider: req.provider, uid: req.uid, user: new_user)
    new_user
  end

  def self.find_for_oauth(req)
    # User.creating_new(req) unless User.find_by_auth(req)
    if User.find_by_auth(req)
      User.find_by_auth(req)
    elsif User.find_by_email(req)
      User.find_by_email(req)
    else
      User.creating_new(req)
    end
  end
end