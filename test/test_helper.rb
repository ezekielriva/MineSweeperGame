ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

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
end
