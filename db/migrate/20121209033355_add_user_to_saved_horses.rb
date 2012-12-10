class AddUserToSavedHorses < ActiveRecord::Migration
  def change
      add_column :saved_horses, :user_id, :integer
  end
end
