class UpdatePhoneVariableType < ActiveRecord::Migration
  def up
      change_column :users, :phone_number, :bigint
  end

  def down
  end
end
