class Horse < ActiveRecord::Base
    belongs_to :user
    
    attr_accessible :age, :breed, :gender, :height, :name, :price, :text_description
    
    validates :age,  :presence => true
    validates :breed, :presence => true
    validates :gender, :presence => true
    validates :height, :presence => true
    validates :name, :presence => true,
    :length => { :minimum => 3 }
    validates :price, :presence => true
    validates :text_description, :presence => true,
    :length => { :minimum => 2 }
    
    def self.search(search)
    search_condition = "%" + search + "%"
    if search_condition
    find(:all, :conditions => ['breed LIKE ? OR name LIKE ?', search_condition, search_condition])
    else
    find(:all)
    end
end
end
