require 'cucumber/rails'
require 'cucumber/rspec/doubles'
require 'capybara-screenshot/cucumber'
require 'capybara/poltergeist'

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Capybara.register_driver :poltergeist do |app|
  options = {
    js_errors: true,
    timeout: 150,
    debug: false,
    phantomjs_options: ['--load-images=no', '--disk-cache=false'],
    inspector: true
  }
  Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.default_driver    = :poltergeist
Capybara.javascript_driver = :poltergeist
Cucumber::Rails::Database.javascript_strategy = :truncation

World Warden::Test::Helpers
Capybara.app_host = "http://localhost:61520"
Capybara.server_port = 61520

After do
  begin
    Warden.test_reset!
  rescue => e
    'nothing'
  end
end