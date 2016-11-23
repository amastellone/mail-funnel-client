class CreateEmailsLists < ActiveRecord::Migration[5.0]
  def change
    create_table :emails_lists do |t|

      t.timestamps
    end
  end
end
