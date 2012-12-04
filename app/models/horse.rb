class Horse < ActiveRecord::Base
    belongs_to :user
    
    attr_accessible :age, :breed, :gender, :height, :name, :price, :text_description
    
    attr_accessible :avatar, :avatar_file_name
    attr_accessor :avatar_file_name
    has_attached_file :avatar, :default_url => "/images/default/:style/default_horse.jpg", :styles => { :large => "900x500", :medium => "450x250", :thumb => "100x100" }, :path => ":rails_root/public/images/:attachment/:id/:style/:filename", :url => "/images/:attachment/:id/:style/:filename"
    
    validates :age,  :presence => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 50 }
    validates :breed, :presence => true
    validates :gender, :presence => true
    validates :height, :presence => true, :numericality => { :greater_than => 4, :less_than_or_equal_to => 20 }
    validates_format_of :height, :with => /^\d+??(?:\.\d{0,1})?$/
    validates :name, :presence => true,
    :length => { :minimum => 3 }
    validates :price, :presence => true
    validates :text_description, :presence => true,
    :length => { :minimum => 2 }
    
    validates :avatar, :attachment_presence => true, :on => :update
    
    ##def self.search(search)
    ##search_condition = "%" + search + "%"
    ##if search_condition
    ##find(:all, :conditions => ['breed LIKE ? OR name LIKE ?', search_condition, search_condition])
    ##else
    ##find(:all)
    ##end
    ##end
end
