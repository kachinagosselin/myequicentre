class Horse < ActiveRecord::Base
    acts_as_gmappable :check_process => false
    
    belongs_to :user
    has_many :subscriptions, :dependent => :destroy

    attr_accessible :dob, :breed, :gender, :height, :name, :price, :text_description
    attr_accessible :address, :city, :state
    attr_accessible :status, :sale_status, :flagged, :active
    attr_accessible :mainimage, :image1, :image2, :image3, :image4

    has_attached_file :mainimage, :styles => { :large => "900x600#", :medium => "452x368#", :thumb => "100x100#" }, :default_url => "/images/default/:style/default_horse.jpg" #, :url => "/:attachment/:id/:style/:avatar_file_name.:extension", :path => ":rails_root/public/:attachment/:id/:style/:avatar_file_name"
    has_attached_file :image1, :styles => { :large => "900x600#", :medium => "452x368#", :thumb => "100x100#" }
    has_attached_file :image2, :styles => { :large => "900x600#", :medium => "452x368#", :thumb => "100x100#" }
    has_attached_file :image3, :styles => { :large => "900x600#", :medium => "452x368#", :thumb => "100x100#" }
    has_attached_file :image4, :styles => { :large => "900x600#", :medium => "452x368#", :thumb => "100x100#" }
    
    VALID_BREEDS = ["akhal-teke", "american saddlebred", "american warmblood", "andalusian", "appaloosa", "arabian", "belgian horse", "belgian sporthorse", "belgian warmblood", "black forest horse", "canadian horse", "canadian sport horse", "canadian warmblood", "caspian horse", "champagne horse", "chincoteague pony", "cleveland bay", "clydesdale", "connemara", "czech warmblood", "dales pony", "danish warmblood", "dartmoor pony", "draft", "dutch warmblood", "fell pony", "fjord", "friesian", "german riding pony", "german warmblood", "grade horse", "gypsy horse", "hackney horse", "hackney pony", "haflinger", "hanoverian", "highland pony", "holsteiner", "hungarian warmblood", "icelandic horse", "international sporthorse", "irish cob", "irish draught", "irish sport horse", "kentucky mountain", "lipizzan", "lusitano", "miniature", "missouri fox trotter horse", "missouri fox trotter pony", "morab", "morgan", "mountain pleasure horse", "mustang", "national show horse", "new forest pony", "new zealand warmblood", "newfoundland pony", "oldenburg", "other", "paint horse", "palomino horse", "paso fino", "percheron", "peruvian paso", "pintabian", "pintaloosa", "pinto", "pinto paso", "pleasure saddle horse registry", "poa", "pony", "quarab", "quarter horse", "quarter pony", "racking horse", "rocky mountain", "selle francais", "shetland pony", "shire", "spanish barb", "spanish mustang", "standardbred", "suffolk", "swedish warmblood", "swiss warmblood", "tennessee walker", "thoroughbred", "trakehner", "warmblood", "welsh cob", "welsh pony"]
    VALID_GENDERS = ["Mare", "Gelding", "Stallion"]
    VALID_HEIGHTS = [4, 4.0, 4.1, 4.2, 4.3, 5, 5.0, 5.1, 5.2, 5.3, 6, 6.0, 6.1, 6.2, 6.3, 7, 7.0, 7.1, 7.2, 7.3, 8, 8.0, 8.1, 8.2, 8.3, 9, 9.0, 9.1, 9.2, 9.3, 10, 10.0, 10.1, 10.2, 10.3, 11, 11.0, 11.1, 11.2, 11.3, 12, 12.0, 12.1, 12.2, 12.3, 13, 13.0, 13.1, 13.2, 13.3, 14, 14.0, 14.1, 14.2, 14.3, 15, 15.0, 15.1, 15.2, 15.3, 16, 16.0, 16.1, 16.2, 16.3, 17, 17.0, 17.1, 17.2, 17.3, 18, 18.0, 18.1, 18.2, 18.3, 19, 19.0, 19.1, 19.2, 19.3, 20, 20.0]
    #before_save :capitalize_fields
    #before_validation :capitalize_fields

    validates :dob,  :presence => true #, :numericality => { :greater_than => 0, :less_than_or_equal_to => 50 }
    validates :breed, :presence => true, :inclusion => { :in => VALID_BREEDS , :message => "%{value} is not a listed breed" }
    validates :gender, :presence => true, :inclusion => { :in => VALID_GENDERS , :message => "%{value} is not a valid gender" }
    validates :height, :presence => true, :numericality => { :greater_than_or_equal_to => 4, :less_than_or_equal_to => 20 }, :inclusion => { :in => VALID_HEIGHTS, :message => "%{value} is not a valid height" }
    validates :name, :presence => true, :length => { :minimum => 3 }
    validates :price, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
    validates :text_description, :presence => true, :length => { :minimum => 10}
    validates :city, :presence => true
    validates :state, :presence => true
   
    def age
        now = Time.now.utc.to_date
        now.year - self.dob.year - ((now.month > self.dob.month || (now.month == self.dob.month && now.day >= self.dob.day)) ? 0 : 1)
    end
    
    def format_description
        self.text_description
    end

    def price=(num)
        num.gsub(/\D/, '') if num.is_a?(String)
        super(num)
    end
    
    def gmaps4rails_address
        "#{self.address} #{self.city}, #{self.state}" 
    end
    
    def gmaps4rails_sidebar
        "<span>#{name}</span>"
    end
end
