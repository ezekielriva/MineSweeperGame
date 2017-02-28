ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

module UserTestHelpers
  def token
    @token ||= ApiKey.new
  end

  def user
    @user ||= User.create(username: 'john_doe', api_key: token)
  end

  def auth_headers
    { "Authorization" =>  "Token token=#{user.access_token}"}
  end
end

class ActiveSupport::TestCase
  fixtures :all

  include UserTestHelpers

  setup { DatabaseCleaner.start }
  teardown { DatabaseCleaner.clean }
end
