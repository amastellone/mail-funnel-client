class CreateHooksConstants < ActiveRecord::Migration[5.0]
  def change
    create_table :hooks_constants do |t|
      t.string :name
      t.references :uuid, foreign_key: true

      t.timestamps
    end
  end
end
