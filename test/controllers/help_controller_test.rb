require 'test_helper'

class HelpControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get contacts" do
    get :contacts
    assert_response :success
  end

  test "should get security" do
    get :security
    assert_response :success
  end

end
