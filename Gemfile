source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "~> 7.1.3"

gem "sprockets-rails"
gem "puma"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "redis"
gem "bootsnap", require: false

gem 'pg'
gem 'csv'
gem 'dotenv-rails'
gem 'rails-i18n'
# gem 'globalize'
# gem 'globalize-accessors'
gem 'activeadmin'
gem 'sassc-rails'
gem 'pagy'
gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'sendgrid-ruby'
gem 'ransack', '~> 4.1'
gem 'aws-sdk-s3'
gem 'sidekiq'
gem "image_processing"
gem 'telegram-bot-ruby' # , "~> 0.19"
gem 'breadcrumbs_on_rails'

group :development, :test do
  gem 'brakeman' # static security analysis
  gem 'faker'
  gem 'pry'
  gem 'capistrano', '~> 3.18', require: false
  gem 'factory_bot_rails'
  gem 'database_cleaner'
end

group :development do
  # gem 'annotate'
  gem 'better_errors' # Shows better errors description on errors page
  gem 'binding_of_caller' # For better errors: activates webconsole directly in browser
  gem 'chusaku', require: false # annotations for routes
  gem 'letter_opener'
  gem 'rails-erd'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'timecop' # work with Time
  gem 'webmock' # emulate and intercept HTTP requests
end
