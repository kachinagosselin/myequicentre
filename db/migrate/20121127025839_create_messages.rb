class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :to_user_id
      t.string :from_user_id
      t.string :title
      t.text :content
      t.references :user
      t.boolean :sent
      t.integer :thread_count
        
      t.timestamps
    end
      
      add_index :messages, :user_id
  end
end
