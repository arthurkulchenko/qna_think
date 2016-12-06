source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'actioncable', '~> 5.0', '>= 5.0.0.1'

gem 'puma'
gem 'haml'
gem 'devise'
gem 'sidekiq'
gem 'sidetiq'
gem 'sinatra', require: nil

gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'remotipart'
gem 'cocoon'
gem 'responders'

gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'cancan'

gem 'doorkeeper'

gem 'active_model_serializers'
gem 'oj'
gem 'oj_mimic_json'

# gem 'gon'

gem 'mysql2'
gem 'thinking-sphinx'

group :production do
  gem 'libv8'
  # gem 'exception_notification'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'letter_opener'
  gem 'capistrano', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-rake', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano3-puma', require: false
  # gem 'capistrano-ssh-doctor', require: false
end

group :development, :test do
  gem 'byebug', platform: :mri

  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'capybara-email'
  gem 'parallel_tests'

  gem 'rails-controller-testing'
end

group :test do
  gem "nyan-cat-formatter"
  gem 'capybara'
  gem 'capybara-webkit'
  # gem 'selenium-webdriver'
  gem 'faker'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'json_spec'
  gem 'rake', '~> 11.3'
end