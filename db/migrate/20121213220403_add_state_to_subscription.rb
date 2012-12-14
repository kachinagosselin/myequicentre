class AddStateToSubscription < ActiveRecord::Migration
  def change
      add_column :subscriptions, :state, :string
  end
end
