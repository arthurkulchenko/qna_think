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

  def merge_user(user)
    user_by_email = self
    elder_user = user.created_at > user_by_email.created_at ? user : user_by_email
    younger_user = user.created_at < user_by_email.created_at ? user : user_by_email
    token = SecureRandom.base64(18)
    # User.reflect_on_all_associations(:has_many)
    [:authorizations].each do |association|
      association.name.to_s.classify.constantize.where(user_id: younger_user.id).each do |class_instance|
        new_attr = class_instance.attributes
        new_attr.delete("id")
        association.name.to_s.classify.constantize.create!(new_attr.merge(user: elder_user, email_confirmation_token: token))
      end
    end
    younger_user.destroy
    elder_user
  end

  def self.find_by_auth(req)
    authorization = Authorization.where(provider: req.provider, uid: req.uid.to_s).first
    user = authorization.user if authorization
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
    if User.find_by_auth(req)
      User.find_by_auth(req)
    elsif User.find_by_email(req)
      User.find_by_email(req)
    else
      User.creating_new(req)
    end
  end
end