require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get sign_in" do
    get auth_sign_in_url
    assert_response :success
  end
end
