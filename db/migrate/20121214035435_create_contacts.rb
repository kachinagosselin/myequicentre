class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :contact_name
      t.integer :contact_id
        t.string :name

      t.timestamps
    end
  end
end
