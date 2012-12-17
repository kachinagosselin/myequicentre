class AddCardDigitsToCustomer < ActiveRecord::Migration
  def change
      add_column :customers, :last_4_digits, :string
  end
end
