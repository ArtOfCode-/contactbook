require 'test_helper'

class HelpAboutControllerTest < ActionController::TestCase
  test "should get whats_this" do
    get :whats_this
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
