class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, # :confirmable, :lockable, :timeoutable
         :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]
  
  [:questions, :answers, :votes, :comments, :attachments, :authorizations, :subscribtions].each do |model|
    has_many model, dependent: :delete_all
  end

  scope :digest_subscribers, -> { where(subscibe_on_digest: true) }

  def is_author_of?(obj)
    obj.user_id == id
  end
  
  def self.find_for_oauth(req)
    authorization = Authorization.where(provider: req.provider, uid: req.uid.to_s).first
    return authorization.user if authorization
    # User.transaction do
      if req.info.has_key?(:email) && user = User.find_by(email: req.info[:email])
        user
      else
        password_generating
        email_genarating(req)
        user = User.create!(email: @g_email, password: @password, password_confirmation: @password, email_real: @r_email )
      end
      user.authorizations.create!(provider: req.provider, uid: req.uid.to_s) if user.authorizations.empty?
    # end
    user
  end

  private

    def merge_into_old(user)
      MergingUsersJob.perform(user, self)
    end
  
    class << self
  
      def associations_list
        reflect_on_all_associations(:has_many).map(&:name)
      end
  
      def sending_digest_newsletter
        DigestLetteringJob.perform()
      end
  
      def email_genarating(req)
        if req.info[:email]
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
  
end