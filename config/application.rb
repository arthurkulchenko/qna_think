require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QaThinknetikaApp
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    config.active_job.queue_adapter = :sidekiq

  	config.generators do |g|
      g.test_framework :rspec,
                  fixtures: true,
                  view_spec: false,
                  helper_specs: false,
                  routing_specs: false,
                  request_specs: false,
                  controller_spec: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
    config.i18n.default_locale = :en #ru
    config.action_cable.disable_request_forgery_protection = false
    config.action_view.embed_authenticity_token_in_remote_forms = true
    # config.middleware.use Warden::Manager
    # config.active_record.raise_in_transactional_callbacks = true
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
