class AddHookIdentifierToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :hook_identifier, :string
  end
end
