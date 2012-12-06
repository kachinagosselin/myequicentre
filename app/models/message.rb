class Message < ActiveRecord::Base
    belongs_to :user
    
    attr_accessible :content, :from_name, :title, :to_name, :folder
    
    validates :content,  :presence => true,
    :length => { :minimum => 5 }
    validates :from_name,  :presence => true
    validates :title, :presence => true,
    :length => { :minimum => 5 }
    validates :to_name,  :presence => true

end
