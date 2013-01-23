class AddMapsToFarms < ActiveRecord::Migration
    def change
        add_column :farms, :address,  :string
        add_column :farms, :latitude,  :float
        add_column :farms, :longitude, :float
        add_column :farms, :gmaps, :boolean
    end
end
