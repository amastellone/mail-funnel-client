class RemoveTypeFromHooksConstants < ActiveRecord::Migration[5.0]
  def change
    remove_column :hooks_constants, :type
  end
end
