class AddHorseToSubscription < ActiveRecord::Migration
  def change
      add_column :subscriptions, :horse_id, :integer
  end
end
