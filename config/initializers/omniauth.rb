Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_app_secret, scope: [:email]
  # provider :twitter, Rails.application.secrets.twitter_app_id, Rails.application.secrets.twitter_app_secret
end