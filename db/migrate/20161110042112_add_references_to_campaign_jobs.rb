class AddReferencesToCampaignJobs < ActiveRecord::Migration[5.0]
  def change
    add_reference :campaign_jobs, :hooks_constant, foreign_key: true
    add_reference :campaign_jobs, :campaign, foreign_key: true
  end
end
