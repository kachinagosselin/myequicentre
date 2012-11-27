class CreateHorses < ActiveRecord::Migration
  def change
    create_table :horses do |t|
      t.string :name
      t.string :breed
      t.string :gender
      t.integer :age
      t.decimal :height
      t.text :text_description
      t.decimal :price
      t.references :user
        
      t.timestamps
    end
      add_index :horses, :user_id
  end
end
