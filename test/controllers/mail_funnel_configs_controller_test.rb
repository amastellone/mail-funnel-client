require 'test_helper'

class MailFunnelConfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mail_funnel_config = mail_funnel_configs(:one)
  end

  test "should get index" do
    get mail_funnel_configs_url
    assert_response :success
  end

  test "should get new" do
    get new_mail_funnel_config_url
    assert_response :success
  end

  test "should create mail_funnel_config" do
    assert_difference('MailFunnelConfig.count') do
      post mail_funnel_configs_url, params: { mail_funnel_config: { name: @mail_funnel_config.name, value: @mail_funnel_config.value } }
    end

    assert_redirected_to mail_funnel_config_url(MailFunnelConfig.last)
  end

  test "should show mail_funnel_config" do
    get mail_funnel_config_url(@mail_funnel_config)
    assert_response :success
  end

  test "should get edit" do
    get edit_mail_funnel_config_url(@mail_funnel_config)
    assert_response :success
  end

  test "should update mail_funnel_config" do
    patch mail_funnel_config_url(@mail_funnel_config), params: { mail_funnel_config: { name: @mail_funnel_config.name, value: @mail_funnel_config.value } }
    assert_redirected_to mail_funnel_config_url(@mail_funnel_config)
  end

  test "should destroy mail_funnel_config" do
    assert_difference('MailFunnelConfig.count', -1) do
      delete mail_funnel_config_url(@mail_funnel_config)
    end

    assert_redirected_to mail_funnel_configs_url
  end
end
