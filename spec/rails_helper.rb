require 'capybara/rspec'
require 'devise'
require 'spec_helper'
require_relative '../config/environment'
require 'rspec/rails'
require 'rails-controller-testing'

ENV['RAILS_ENV'] ||= 'test'

abort("The Rails environment is running in production mode!") if Rails.env.production?

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.extend ControllerMacros, type: :controller

  config.use_transactional_fixtures = true

  [:controller, :view, :request].each do |type|
    config.include Rails::Controller::Testing::TemplateAssertions, type: type
    config.include Rails::Controller::Testing::Integration, type: type
    config.include Rails::Controller::Testing::TestProcess, type: type
  end

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
