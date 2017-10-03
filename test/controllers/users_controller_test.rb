require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should get new" do
    get users_new_url
    assert_response :success
  end

  test "should get sign_in" do
    get users_sign_in_url
    assert_response :success
  end

  test "should get forget_password" do
    get users_forget_password_url
    assert_response :success
  end

end
