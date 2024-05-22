require 'cucumber/rails'
require 'RSpec/rails'
require Rails.root.join('spec', 'support', 'capybara')
require 'database_cleaner'

ActionController::Base.allow_rescue = false

Before do
  @user = FactoryBot.build(:user)
  @user.save
end

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Around do |scenario, block|
  DatabaseCleaner.cleaning(&block)
end

Cucumber::Rails::Database.javascript_strategy = :truncation
Capybara.default_driver = :selenium_chrome
Capybara.javascript_driver = :selenium_chrome

ENV['CR_REMOVE_RACK_TEST_HELPERS'] = 'true'
