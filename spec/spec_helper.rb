require "rspec"
require "webmock/rspec"
require "sociable"
require "factories/facebook_hash"
require 'factory_girl'
require 'mongoid'
require 'devise'

Mongoid.load!(File.join(File.dirname(__FILE__), "config/mongoid.yml"), :test)

Mongoid.configure do |config|
  config.connect_to(:test)
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.include Mongoid::Matchers

  require 'database_cleaner'
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

end

require 'pry'
require 'spork'

# Loading more in this block will cause your tests to run faster.
# if you change any configuration or code from libraries loaded
# need to restart spork for it take effect.
Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
  end
end

# Spork.each_run do
#   #ActiveSupport::Dependencies.clear
#   #Fabrication.clear_definitions
#   #I18n.backend.reload!
# end if ENV['drb']

