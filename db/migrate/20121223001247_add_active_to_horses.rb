class AddActiveToHorses < ActiveRecord::Migration
  def change
      add_column :horses, :active, :boolean
  end
end
