class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.integer :hook

      t.timestamps
    end
  end
end
