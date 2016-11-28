class AddCellToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :cell, :string
  end
end
