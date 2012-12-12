class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.integer :user_id
      t.string :stripe_customer_token

      t.timestamps
    end
  end
end
