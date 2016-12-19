class AddIndexToMailFunnelConfig < ActiveRecord::Migration[5.0]
  def change
    add_index :mail_funnel_configs, :name, unique: true
  end
end
