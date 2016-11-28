class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|

      t.timestamps
    end
  end
end
