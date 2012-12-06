class Message < ActiveRecord::Base
    belongs_to :user
    
    attr_accessible :content, :from_user_id, :title, :to_user_id, :folder, :sent, :thread_count
    
    validates :content,  :presence => true,
    :length => { :minimum => 5 }
    validates :from_user_id,  :presence => true
    validates :title, :presence => true,
    :length => { :minimum => 5 }
    validates :to_user_id,  :presence => true
    
    def from_name
        fn = User.find(self.from_user_id).first_name 
        ln = User.find(self.from_user_id).last_name
        from_name ="#{fn} #{ln}"
    end
    
    def to_name
        fn = User.find(self.to_user_id).first_name 
        ln = User.find(self.to_user_id).last_name
        to_name ="#{fn} #{ln}"
    end
    
end
