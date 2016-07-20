ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'devise'
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec    
    with.library :active_record
    with.library :active_model
    with.library :action_controller
    with.library :rails
  end
end

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  # config.include Devise::TestHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :controller
  # ------------------------------------------------------------
  config.extend ControllerMacros, type: :controller
  # TODO - Спросить
  #   qa_thinknetika_app/spec/rails_helper.rb:43:in
  #   `block in <top (required)>': uninitialized constant ControllerMacros (NameError)
  # ------------------------------------------------------------
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_gems_from_backtrace

  [:controller, :view, :request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, :type => type
    config.include ::Rails::Controller::Testing::TemplateAssertions, :type => type
    config.include ::Rails::Controller::Testing::Integration, :type => type
  end
end
