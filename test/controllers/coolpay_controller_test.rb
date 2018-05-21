require 'test_helper'

class CoolpayControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get coolpay_login_url
    assert_response :success
  end

end
