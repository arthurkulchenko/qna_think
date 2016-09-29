ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!


require 'devise'

OmniAuth.config.test_mode = true

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec    
    with.library :active_record
    with.library :active_model
    with.library :action_controller
    with.library :rails
  end
end

Capybara.configure do |config|
  config.javascript_driver = :webkit # :selenium
  config.ignore_hidden_elements = false
end

RSpec.configure do |config|
  
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.extend ControllerMacros, type: :controller
  config.include(OmniauthMacros)
  
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  # config.use_transactional_tests = false
  config.use_transactional_fixtures = true
  
  config.infer_spec_type_from_file_location!
  config.filter_gems_from_backtrace

  [:controller, :view, :request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, :type => type
    config.include ::Rails::Controller::Testing::TemplateAssertions, :type => type
    config.include ::Rails::Controller::Testing::Integration, :type => type
  end
end
