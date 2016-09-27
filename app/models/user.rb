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

  def self.find_for_auth(request)
    authorization = Authorization.where(provider: request.provider, uid: request.uid.to_s).first
    password = Devise.friendly_token[0..20]
    generated_email = "#{request.provider}-#{request.uid}@email.com"
    user = 
            if authorization
              authorization.user
            else
              user_by_email = User.find_by(email: request.info[:email]) if request.info[:email]
              Authorization.create!(provider: request.provider, uid: request.uid, user: user_by_email)
              if !user_by_email.persisted?
                new_user = User.create!(email: generated_email, password: password, password_confirmation: password )
                Authorization.create!(provider: request.provider, uid: request.uid, user: new_user)
                return new_user
              else
              end
              user_by_email
            end
  end
end