source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "~> 7.0.8"

gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "bootsnap", require: false

gem 'pg', '~> 1.5'
gem 'csv'
gem 'devise'
gem 'dotenv-rails'
gem 'rails-i18n'
gem 'globalize'
gem 'globalize-accessors'
gem 'activeadmin'
gem 'sassc-rails'
gem 'kaminari'

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem 'brakeman' # report vulnerabilities
  gem 'faker'
  gem 'pry'
end

group :development do
  gem 'annotate'
  gem 'better_errors' # Shows better errors description on errors page
  gem 'binding_of_caller'
  gem 'chusaku', require: false # annotations for routes
  gem 'letter_opener'
  gem 'listen' # Monitoring changes in files and directories in real-time
  gem 'rails-erd'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end
