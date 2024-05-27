require 'cucumber/rails'
require 'rspec/rails'
require Rails.root.join('spec', 'support', 'capybara')
require 'database_cleaner/active_record'

ActionController::Base.allow_rescue = false

Before do
  @user = FactoryBot.build(:user)
  @user.save
end

begin
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.allow_remote_database_url = true
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Before do
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end

Cucumber::Rails::Database.javascript_strategy = :truncation

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :selenium_chrome_headless
Capybara.javascript_driver = :selenium_chrome

ENV['CR_REMOVE_RACK_TEST_HELPERS'] = 'true'
