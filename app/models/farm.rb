class Farm < ActiveRecord::Base
    acts_as_gmappable :check_process => false
    geocoded_by :gmaps4rails_address   
    after_validation :geocode          # auto-fetch coordinates

    belongs_to :user
    attr_accessible :capacity, :city, :description, :name, :phone, :rate, :state, :website, :address, :user_id
    attr_accessible :mainimage
    
    has_attached_file :mainimage, :styles => {:medium => "452x368#", :thumb => "100x100#" }, :default_url => "/images/default_barn.jpg"
    validates :name, :presence => true, :uniqueness => true
    validates :state, :presence => true
    validates :city, :presence => true

    search_methods :distance
    
    def gmaps4rails_address
        "#{self.city}, #{self.state}" 
    end
    
    def gmaps4rails_sidebar
        "<span>#{name}</span>"
    end
end
