class AddStatusToUser < ActiveRecord::Migration
  def change
      add_column :users, :status, :string
      add_column :users, :flagged, :boolean
  end
end
