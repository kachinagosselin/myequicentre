class AddStatusToHorses < ActiveRecord::Migration
  def change
      add_column :horses, :sale_status, :string
      add_column :horses, :status, :string
      add_column :horses, :flagged, :boolean
  end
end
