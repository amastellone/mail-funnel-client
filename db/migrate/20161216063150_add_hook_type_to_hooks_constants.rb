class AddHookTypeToHooksConstants < ActiveRecord::Migration[5.0]
  def change
    add_reference :hooks_constants, :hook_type, foreign_key: true
  end
end
