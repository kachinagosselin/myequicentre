class AddMapsToHorses < ActiveRecord::Migration
  def change
      add_column :horses, :address, :string
      add_column :horses, :gmaps, :boolean
  end
end
