require 'test_helper'

class EmailListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @email_list = email_lists(:one)
  end

  test "should get index" do
    get email_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_email_list_url
    assert_response :success
  end

  test "should create email_list" do
    assert_difference('EmailList.count') do
      post email_lists_url, params: { email_list: { app_id: @email_list.app_id, description: @email_list.description, name: @email_list.name } }
    end

    assert_redirected_to email_list_url(EmailList.last)
  end

  test "should show email_list" do
    get email_list_url(@email_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_email_list_url(@email_list)
    assert_response :success
  end

  test "should update email_list" do
    patch email_list_url(@email_list), params: { email_list: { app_id: @email_list.app_id, description: @email_list.description, name: @email_list.name } }
    assert_redirected_to email_list_url(@email_list)
  end

  test "should destroy email_list" do
    assert_difference('EmailList.count', -1) do
      delete email_list_url(@email_list)
    end

    assert_redirected_to email_lists_url
  end
end
