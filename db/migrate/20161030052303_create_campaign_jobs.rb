class CreateCampaignJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_jobs do |t|
      t.references :campaign_id, foreign_key: true
      t.references :job_uuid, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
