class RemoveTestimonials < ActiveRecord::Migration
    def up
        drop_table :testimonials
    end
    
    def down
    end
end
