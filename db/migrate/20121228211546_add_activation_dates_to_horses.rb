class AddActivationDatesToHorses < ActiveRecord::Migration
  def change
      add_column :horses, :activated_at, :datetime
      add_column :horses, :deactivated_at, :datetime
  end
end
