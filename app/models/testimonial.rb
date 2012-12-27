class Testimonial < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :horse_id
    
    validates :body, :presence => true
    validates :horse_id, :presence => true 
end
