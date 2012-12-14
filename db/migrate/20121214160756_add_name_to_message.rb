class AddNameToMessage < ActiveRecord::Migration
  def change
      add_column :messages, :to_name, :string
  end
end
