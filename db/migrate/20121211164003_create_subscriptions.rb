class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :plan_id
      t.integer :user_id
      t.integer :number_of_listings
        
      t.timestamps
    end
      add_index :subscriptions, :user_id
  end
end
