require 'test_helper'

class SocialemailControllerTest < ActionController::TestCase
  test "should get email" do
    get :email
    assert_response :success
  end

end
