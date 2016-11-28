class DeleteXColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :campaigns, :x
    remove_column :campaigns, :y
    remove_column :campaigns, :cell

  end
end
