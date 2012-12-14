class Message < ActiveRecord::Base
    belongs_to :user
    
    attr_accessible :content, :from_user_id, :title, :to_user_id, :name, :folder, :sent, :thread_count, :parent_id, :created_at, :updated_at
    
    validates :content,  :presence => true,
    :length => { :minimum => 3 }
    validates :from_user_id,  :presence => true
    validates :title, :presence => true,
    :length => { :minimum => 3 }
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
    
    def return_time
    self.updated_at.in_time_zone('Hawaii').to_formatted_s(:long_ordinal)
    end
end
