require 'test_helper'

class PublicBlugsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get public_blugs_home_url
    assert_response :success
  end

end
