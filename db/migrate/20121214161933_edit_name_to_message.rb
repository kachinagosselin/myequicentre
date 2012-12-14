class EditNameToMessage < ActiveRecord::Migration
  def change
      add_column :messages, :name, :string
      remove_column :messages, :to_name
  end
end
