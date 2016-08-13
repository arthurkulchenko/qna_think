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

gem 'thin'
gem 'haml'
gem 'devise'

gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
# gem 'remotipart', github: 'mshibuya/remotipart', ref: '3a6acb3'
gem 'cocoon'

gem 'private_pub'
gem 'oauth'
gem 'sphinx'
gem 'cancan'
gem 'pundit'
gem 'responders'

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
  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-ssh-doctor'
end

group :development, :test do
  gem 'byebug', platform: :mri

  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'

  gem 'rails-controller-testing'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  # gem 'selenium-webdriver'
  gem 'faker'
  gem 'database_cleaner'
  gem 'launchy'
end