class AddLocationToHorse < ActiveRecord::Migration
  def change
      add_column :horses, :city, :string
      add_column :horses, :state, :string
      add_column :horses, :zip_id, :integer
  end
end
