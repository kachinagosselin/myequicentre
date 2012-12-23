class AddAttachmentImagesToHorses < ActiveRecord::Migration
    def up
        add_attachment :horses, :mainimage
        add_attachment :horses, :image1
        add_attachment :horses, :image2
        add_attachment :horses, :image3
        add_attachment :horses, :image4
    end
    
    def down
        remove_attachment :horses, :mainimage
        remove_attachment :horses, :image1
        remove_attachment :horses, :image2
        remove_attachment :horses, :image3
        remove_attachment :horses, :image4
    end
end
