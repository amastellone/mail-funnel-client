class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.references :hook_uuid, foreign_key: true

      t.timestamps
    end
  end
end
