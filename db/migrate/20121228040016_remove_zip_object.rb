class RemoveZipObject < ActiveRecord::Migration
  def up
      drop_table :zips
      remove_column :users, :zip_id
      remove_column :horses, :zip_id
  end

  def down
  end
end
