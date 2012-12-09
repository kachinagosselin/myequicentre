class CreateZips < ActiveRecord::Migration
  def change
    create_table :zips do |t|
      t.string :code
      t.string :city
      t.string :state
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :lon, :precision => 15, :scale => 10

      t.timestamps
    end
  end
end
