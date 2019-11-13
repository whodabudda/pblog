require 'test_helper'

class UserOptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_option = user_options(:one)
  end

  test "should get index" do
    get user_options_url
    assert_response :success
  end

  test "should get new" do
    get new_user_option_url
    assert_response :success
  end

  test "should create user_option" do
    assert_difference('UserOption.count') do
      post user_options_url, params: { user_option: { email: @user_option.email, notification: @user_option.notification, sms: @user_option.sms, subscription: @user_option.subscription, user_id: @user_option.user_id } }
    end

    assert_redirected_to user_option_url(UserOption.last)
  end

  test "should show user_option" do
    get user_option_url(@user_option)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_option_url(@user_option)
    assert_response :success
  end

  test "should update user_option" do
    patch user_option_url(@user_option), params: { user_option: { email: @user_option.email, notification: @user_option.notification, sms: @user_option.sms, subscription: @user_option.subscription, user_id: @user_option.user_id } }
    assert_redirected_to user_option_url(@user_option)
  end

  test "should destroy user_option" do
    assert_difference('UserOption.count', -1) do
      delete user_option_url(@user_option)
    end

    assert_redirected_to user_options_url
  end
end
