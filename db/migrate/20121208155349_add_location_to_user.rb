class AddLocationToUser < ActiveRecord::Migration
  def change
      add_column :users, :address, :string
      add_column :users, :city, :string
      add_column :users, :state, :string
      add_column :users, :zip_id, :integer
  end
end
