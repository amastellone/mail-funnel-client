require 'test_helper'

class HooksConstantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hooks_constant = hooks_constants(:one)
  end

  test "should get index" do
    get hooks_constants_url
    assert_response :success
  end

  test "should get new" do
    get new_hooks_constant_url
    assert_response :success
  end

  test "should create hooks_constant" do
    assert_difference('HooksConstant.count') do
      post hooks_constants_url, params: { hooks_constant: { name: @hooks_constant.name, uuid_id: @hooks_constant.uuid_id } }
    end

    assert_redirected_to hooks_constant_url(HooksConstant.last)
  end

  test "should show hooks_constant" do
    get hooks_constant_url(@hooks_constant)
    assert_response :success
  end

  test "should get edit" do
    get edit_hooks_constant_url(@hooks_constant)
    assert_response :success
  end

  test "should update hooks_constant" do
    patch hooks_constant_url(@hooks_constant), params: { hooks_constant: { name: @hooks_constant.name, uuid_id: @hooks_constant.uuid_id } }
    assert_redirected_to hooks_constant_url(@hooks_constant)
  end

  test "should destroy hooks_constant" do
    assert_difference('HooksConstant.count', -1) do
      delete hooks_constant_url(@hooks_constant)
    end

    assert_redirected_to hooks_constants_url
  end
end
