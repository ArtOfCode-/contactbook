require 'test_helper'

class HelpSecurityControllerTest < ActionController::TestCase
  test "should get tech" do
    get :tech
    assert_response :success
  end

  test "should get bugs" do
    get :bugs
    assert_response :success
  end

end
