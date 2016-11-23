class CreateHooksConstants < ActiveRecord::Migration[5.0]
  def change
    create_table :hooks_constants do |t|
      t.string :name
      t.string :identifier

      t.timestamps
    end
  end
end
