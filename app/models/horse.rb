class Horse < ActiveRecord::Base
    belongs_to :user
    has_many :subscriptions, :dependent => :destroy

    attr_accessible :dob, :breed, :gender, :height, :name, :price, :text_description
    attr_accessible :city, :state, :zip_id
    attr_accessible :status, :sale_status, :flagged, :active

    attr_accessible :mainimage, :image1, :image2, :image3, :image4

    has_attached_file :mainimage, :styles => { :large => "900x600#", :medium => "452x368#", :thumb => "100x100#" }, :default_url => "/images/default/:style/default_horse.jpg" #, :url => "/:attachment/:id/:style/:avatar_file_name.:extension", :path => ":rails_root/public/:attachment/:id/:style/:avatar_file_name"
    has_attached_file :image1, :styles => { :large => "900x600#", :medium => "452x368#", :thumb => "100x100#" }, :default_url => "/images/default/:style/default_horse.jpg" #, :url => "/:attachment/:id/:style/:avatar_file_name.:extension", :path => ":rails_root/public/:attachment/:id/:style/:avatar_file_name"
    has_attached_file :image2, :styles => { :large => "900x600#", :medium => "452x368#", :thumb => "100x100#" }, :default_url => "/images/default/:style/default_horse.jpg" #, :url => "/:attachment/:id/:style/:avatar_file_name.:extension", :path => ":rails_root/public/:attachment/:id/:style/:avatar_file_name"
    has_attached_file :image3, :styles => { :large => "900x600#", :medium => "452x368#", :thumb => "100x100#" }, :default_url => "/images/default/:style/default_horse.jpg" #, :url => "/:attachment/:id/:style/:avatar_file_name.:extension", :path => ":rails_root/public/:attachment/:id/:style/:avatar_file_name"
    has_attached_file :image4, :styles => { :large => "900x600#", :medium => "452x368#", :thumb => "100x100#" }, :default_url => "/images/default/:style/default_horse.jpg" #, :url => "/:attachment/:id/:style/:avatar_file_name.:extension", :path => ":rails_root/public/:attachment/:id/:style/:avatar_file_name"
    
    VALID_BREEDS = ["Akhal-Teke", "American Saddlebred", "American Warmblood", "Andalusian", "Appaloosa", "Arabian", "Belgian Horse", "Belgian Sporthorse", "Belgian Warmblood", "Black Forest Horse", "Canadian Horse", "Canadian Sport Horse", "Canadian Warmblood", "Caspian Horse", "Champagne Horse", "Chincoteague Pony", "Cleveland Bay", "Clydesdale", "Connemara", "Czech Warmblood", "Dales Pony", "Danish Warmblood", "Dartmoor Pony", "Draft", "Dutch Warmblood", "Fell Pony", "Fjord", "Friesian", "German Riding Pony", "German Warmblood", "Grade Horse", "Gypsy Horse", "Hackney Horse", "Hackney Pony", "Haflinger", "Hanoverian", "Highland Pony", "Holsteiner", "Hungarian Warmblood", "Icelandic Horse", "International Sporthorse", "Irish Cob", "Irish Draught", "Irish Sport Horse", "Kentucky Mountain", "Lipizzan", "Lusitano", "Miniature", "Missouri Fox Trotter Horse", "Missouri Fox Trotter Pony", "Morab", "Morgan", "Mountain Pleasure Horse", "Mustang", "National Show Horse", "New Forest Pony", "New Zealand Warmblood", "Newfoundland Pony", "Oldenburg", "Other", "Paint Horse", "Palomino Horse", "Paso Fino", "Percheron", "Peruvian Paso", "Pintabian", "Pintaloosa", "Pinto", "Pinto Paso", "Pleasure Saddle Horse Registry", "POA", "Pony", "Quarab", "Quarter Horse", "Quarter Pony", "Racking Horse", "Rocky Mountain", "Selle Francais", "Shetland Pony", "Shire", "Spanish Barb", "Spanish Mustang", "Standardbred", "Suffolk", "Swedish Warmblood", "Swiss Warmblood", "Tennessee Walker", "Thoroughbred", "Trakehner", "Warmblood", "Welsh Cob", "Welsh Pony"]
    VALID_GENDERS = ["Mare", "Gelding", "Stallion"]
    VALID_HEIGHTS = [4.0, 4.1, 4.2, 4.3, 5.0, 5.1, 5.2, 5.3, 6.0, 6.1, 6.2, 6.3, 7.0, 7.1, 7.2, 7.3, 8.0, 8.1, 8.2, 8.3, 9.0, 9.1, 9.2, 9.3, 10.0, 10.1, 10.2, 10.3, 11.0, 11.1, 11.2, 11.3, 12.0, 12.1, 12.2, 12.3, 13.0, 13.1, 13.2, 13.3, 14.0, 14.1, 14.2, 14.3, 15.0, 15.1, 15.2, 15.3, 16.0, 16.1, 16.2, 16.3, 17.0, 17.1, 17.2, 17.3, 18.0, 18.1, 18.2, 18.3, 19.0, 19.1, 19.2, 19.3, 20.0]
    #before_save :capitalize_fields
    #before_validation :capitalize_fields
    
    validates :dob,  :presence => true #, :numericality => { :greater_than => 0, :less_than_or_equal_to => 50 }
    validates :breed, :presence => true, :inclusion => { :in => VALID_BREEDS , :message => "%{value} is not a listed breed" }
    validates :gender, :presence => true, :inclusion => { :in => VALID_GENDERS , :message => "%{value} is not a valid gender" }
    validates :height, :presence => true, :numericality => { :greater_than_or_equal_to => 4, :less_than_or_equal_to => 20 }, :inclusion => { :in => VALID_HEIGHTS, :message => "%{value} is not a valid height" }
    validates :name, :presence => true, :length => { :minimum => 3 }
    validates :price, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
    validates :text_description, :presence => true, :length => { :minimum => 10}
    #validates :city
    #validates :state
    #validates :zip_id
   
    #validates :avatar, :attachment_presence => true, :on => :update

    def age
        now = Time.now.utc.to_date
        now.year - self.dob.year - ((now.month > self.dob.month || (now.month == self.dob.month && now.day >= self.dob.day)) ? 0 : 1)
    end
    
    def format_description
        self.text_description
    end
    
end
