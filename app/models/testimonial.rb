class Testimonial < ActiveRecord::Base
  belongs_to :user
    attr_accessible :body, :horse_id, :voucher_id
    
    validates :voucher_id, :presence => true
    validates :body, :presence => true
end
