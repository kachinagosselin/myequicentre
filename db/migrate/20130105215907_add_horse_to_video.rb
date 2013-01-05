class AddHorseToVideo < ActiveRecord::Migration
  def change
      add_column :videos, :horse_id, :integer
  end
end
