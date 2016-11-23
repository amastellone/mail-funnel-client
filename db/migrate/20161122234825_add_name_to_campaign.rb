class AddNameToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :name, :string
  end
end
