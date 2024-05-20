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
gem 'globalize'
gem 'globalize-accessors'
gem 'activeadmin'
gem 'sassc-rails'
gem 'kaminari'
gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'sendgrid-ruby'
gem 'ransack', '~> 4.1'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem 'brakeman' # report vulnerabilities
  gem 'faker'
  gem 'pry'
  gem 'capistrano', '~> 3.18', require: false
  # gem "capistrano-rails", '~> 1.6', require: false
end

group :development do
  gem 'annotate'
  gem 'better_errors' # Shows better errors description on errors page
  gem 'binding_of_caller'
  gem 'chusaku', require: false # annotations for routes
  gem 'factory_bot_rails'
  gem 'letter_opener'
  gem 'listen' # Monitoring changes in files and directories in real-time
  gem 'rails-erd'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'web-console'
  gem 'database_cleaner'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end
