require 'test_helper'

class ExportsControllerTest < ActionController::TestCase
  test "should get json" do
    get :json
    assert_response :success
  end

  test "should get xml" do
    get :xml
    assert_response :success
  end

end
