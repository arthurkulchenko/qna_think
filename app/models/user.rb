class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, # :confirmable, :lockable, :timeoutable
         :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]
  
  [:questions, :answers, :votes, :comments, :attachments, :authorizations].each do |model|
    has_many model, dependent: :delete_all
  end

  scope :digest_subscribers, -> { where(subscibe_on_digest: true) }
  scope :subscribed_on_changings, -> (question) { where(subsctiptions: question) }

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

  def self.sending_digest_newsletter
    self.digest_subscribers.find_each do |user|
      # if Date.today.at_middle_of_day
        QuestionSubscriptionMailer.send_digest(user, Question.last_24_hours)#.deliver_later#(:queue)
      # end
    end
  end

  class << self

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

  def merge_this(user)
    User.transaction do
      user.authorizations.each do |auth|
        auth.update(user_id: id)
      end
      user.destroy
      save
    end
    self
  end
  # handle_asynchronously :merge_this
  
end