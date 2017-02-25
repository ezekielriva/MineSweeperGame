require 'test_helper'

class StatusControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get api_v1_status_url
    assert_response :success
  end
end
