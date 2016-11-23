class CreateCampaignJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_jobs do |t|
      t.integer :job
      t.integer :position

      t.timestamps
    end
  end
end
