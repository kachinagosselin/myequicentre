class CreateFarms < ActiveRecord::Migration
  def change
    create_table :farms do |t|
      t.string :name
      t.text :description
      t.integer :phone
      t.string :website
      t.integer :rate
      t.integer :capacity
      t.string :city
      t.string :state
      t.references :user

      t.timestamps
    end
    add_index :farms, :user_id
  end
end
