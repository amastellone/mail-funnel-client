class AddXAndYToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :x, :float
    add_column :campaigns, :y, :float
  end
end
