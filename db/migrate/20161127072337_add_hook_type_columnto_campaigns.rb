class AddHookTypeColumntoCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :hooks_constants, :hook_type, :string
  end
end
