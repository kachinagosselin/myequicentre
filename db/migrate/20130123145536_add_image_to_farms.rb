class AddImageToFarms < ActiveRecord::Migration
    def self.up
        add_attachment :farms, :mainimage
    end
    
    def self.down
        remove_attachment :farms, :mainimage
    end
end
