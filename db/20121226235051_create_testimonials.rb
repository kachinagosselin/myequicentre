class CreateTestimonials < ActiveRecord::Migration
    def change
        create_table :testimonials do |t|
            t.string :body
            t.integer :horse_id
            t.references :user
            
            t.timestamps
        end
        
        add_index :testimonials, :user_id
    end
end
