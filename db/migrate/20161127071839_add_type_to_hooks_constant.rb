class AddTypeToHooksConstant < ActiveRecord::Migration[5.0]
  def change
    add_column :hooks_constants, :type, :string
  end
end
