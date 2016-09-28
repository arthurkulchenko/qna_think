class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]
  
  [:questions, :answers, :votes, :comments, :attachments, :authorizations].each do |model|
    has_many model, dependent: :destroy
  end

  def is_author_of?(obj)
    obj.user_id == id
  end

  def self.find_with_authorization(request)
    authorization = Authorization.where(provider: request.provider, uid: request.uid.to_s).first
    user = authorization.user if authorization
  end

  def self.find_by_email(request)
    user = User.find_by(email: request.info[:email]) if request.info
    if user
      if !user.authorizations.where(provider: request.provider, uid: request.uid.to_s).first
        Authorization.create!(provider: request.provider, uid: request.uid, user: user)  
      end
    end
    user
  end

  def self.creating_new(request)
    password = Devise.friendly_token[0..20]
    g_email = "#{request.provider}-#{request.uid}@email.com"
    new_user = User.create!(email: g_email, password: password, password_confirmation: password )
    Authorization.create!(provider: request.provider, uid: request.uid, user: new_user)
    new_user
  end

  def self.find_for_auth(request)
    if User.find_with_authorization(request)
      User.find_with_authorization(request)
    elsif User.find_by_email(request)
      User.find_by_email(request)
    else
      User.creating_new(request)
    end
  end
end