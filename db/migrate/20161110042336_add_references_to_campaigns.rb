class AddReferencesToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_reference :campaigns, :hooks_constant, foreign_key: true
  end
end
