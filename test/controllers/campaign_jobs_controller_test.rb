require 'test_helper'

class CampaignJobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campaign_job = campaign_jobs(:one)
  end

  test "should get index" do
    get campaign_jobs_url
    assert_response :success
  end

  test "should get new" do
    get new_campaign_job_url
    assert_response :success
  end

  test "should create campaign_job" do
    assert_difference('CampaignJob.count') do
      post campaign_jobs_url, params: { campaign_job: { campaign_id_id: @campaign_job.campaign_id_id, job_uuid_id: @campaign_job.job_uuid_id, position: @campaign_job.position } }
    end

    assert_redirected_to campaign_job_url(CampaignJob.last)
  end

  test "should show campaign_job" do
    get campaign_job_url(@campaign_job)
    assert_response :success
  end

  test "should get edit" do
    get edit_campaign_job_url(@campaign_job)
    assert_response :success
  end

  test "should update campaign_job" do
    patch campaign_job_url(@campaign_job), params: { campaign_job: { campaign_id_id: @campaign_job.campaign_id_id, job_uuid_id: @campaign_job.job_uuid_id, position: @campaign_job.position } }
    assert_redirected_to campaign_job_url(@campaign_job)
  end

  test "should destroy campaign_job" do
    assert_difference('CampaignJob.count', -1) do
      delete campaign_job_url(@campaign_job)
    end

    assert_redirected_to campaign_jobs_url
  end
end
