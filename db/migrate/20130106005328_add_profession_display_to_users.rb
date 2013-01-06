class AddProfessionDisplayToUsers < ActiveRecord::Migration
  def change
      add_column :users, :profession, :string
      add_column :users, :professional_listing, :boolean
  end
end
