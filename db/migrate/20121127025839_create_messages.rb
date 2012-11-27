class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :to_name
      t.string :from_name
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
