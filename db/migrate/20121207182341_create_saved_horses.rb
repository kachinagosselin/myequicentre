class CreateSavedHorses < ActiveRecord::Migration
  def change
    create_table :saved_horses do |t|
      t.decimal :horse_id
      t.boolean :saved

      t.timestamps
    end
  end
end
