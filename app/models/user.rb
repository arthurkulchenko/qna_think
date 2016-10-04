# class User < ApplicationRecord
#   devise :database_authenticatable, :registerable, :recoverable, :rememberable, # :confirmable, :lockable, :timeoutable
#          :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]
  
#   [:questions, :answers, :votes, :comments, :attachments, :authorizations].each do |model|
#     has_many model, dependent: :destroy
#   end

#   def is_author_of?(obj)
#     obj.user_id == id
#   end

#   def merge_this(user)
#     user.authorizations.each do |auth|
#       new_attr = auth.attributes
#       new_attr.delete("id")
#       authorizations.create!(new_attr)
#     end
#     user.destroy
#     save
#     self
#   end

#   class << self
#     def find_by_auth(req)
#       authorization = Authorization.where(provider: req.provider, uid: req.uid.to_s).first
#       authorization.user if authorization
#     end

#     def find_by_email(req)
#       token = SecureRandom.base64(18)
#       user = User.find_by(email: req.info[:email]) if req.info.has_key?(:email)
#       if user && user.authorizations.empty?
#         user.authorizations.create!(provider: req.provider, uid: req.uid.to_s, confirmation_token: token)
#       end
#       user
#     end
  
#     def creating_new(req)
#       password = Devise.friendly_token[0..20]
#       token = SecureRandom.base64(18)
#       if req.info.has_key?(:email)
#         r_email = true
#         g_email = req.info[:email]
#       else
#         r_email = false
#         g_email = "#{req.provider}-#{req.uid}@email.com"
#       end
#       user = User.create!(email: g_email, password: password, password_confirmation: password, email_real: r_email )
#       user.authorizations.create!(provider: req.provider, uid: req.uid.to_s, confirmation_token: token)
#       user
#     end
  
#     def find_for_oauth(req)
#       if User.find_by_auth(req)
#         User.find_by_auth(req)
#       else
#         if User.find_by_email(req)
#           User.find_by_email(req)
#         else
#           User.creating_new(req)
#         end
#       end
#     end
#   end

  
# end
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, # :confirmable, :lockable, :timeoutable
         :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]
  
  [:questions, :answers, :votes, :comments, :attachments, :authorizations].each do |model|
    has_many model, dependent: :destroy
  end
  
  def self.find_for_oauth(req)
    authorization = Authorization.where(provider: req.provider, uid: req.uid.to_s).first
    # Ищем по авторизации
    if authorization
      authorization.user
    # Если не нашли по авторизации, то ищем по почте, если та дана,
    # если дана, то тут же проверяем если авторизации, если нет то созадем
    elsif req.info.has_key?(:email) && user = User.find_by(email: req.info[:email])
      token_and_password_generating
      if user && user.authorizations.empty?
        user.authorizations.create!(provider: req.provider, uid: req.uid.to_s, confirmation_token: @token)
      end
      user
    # Если нет не на авторизации не почты, то создаем и то и другое
    else
      token_and_password_generating
      @token = SecureRandom.base64(18)
      email_genarating(req)
      user = User.create!(email: @g_email, password: @password, password_confirmation: @password, email_real: @r_email )
      user.authorizations.create!(provider: req.provider, uid: req.uid.to_s, confirmation_token: @token)
      user
    end
  end

  def self.token_and_password_generating
    
    @password = Devise.friendly_token[0..20]      
  end

  private

  def self.email_genarating(req)
    if req.info.has_key?(:email)
      @r_email = true
      @g_email = req.info[:email]
    else
      @r_email = false
      @g_email = "#{req.provider}-#{req.uid}@email.com"
    end
  end

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
  
end