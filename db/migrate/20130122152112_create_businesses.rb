class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.text :description
      t.integer :phone
      t.string :website
      t.string :city
      t.string :state
      t.references :user

      t.timestamps
    end
    add_index :businesses, :user_id
  end
end
