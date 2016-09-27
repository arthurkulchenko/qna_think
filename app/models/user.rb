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
    authorization = Authorization.where(provider: request.provider, uid: request.uid)
    user = 
    if authorization
      authorization.user
    else
      
    end
  end
end