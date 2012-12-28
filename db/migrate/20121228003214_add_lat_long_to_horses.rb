class AddLatLongToHorses < ActiveRecord::Migration
  def change
      add_column :horses, :latitude,  :float
      add_column :horses, :longitude, :float
  end
end
