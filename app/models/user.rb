class User < ActiveRecord::Base
    rolify
    if true
    acts_as_gmappable :check_process => false, :validation => false
    geocoded_by :gmaps4rails_address   
    after_validation :geocode          # auto-fetch coordinates
    end

    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :mailchimp

  # Setup accessible (or protected) attributes for your model
    attr_accessible :role_ids, :as => :admin
    attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :phone_number, :website
    attr_accessible :address, :city, :state
    attr_accessible :bio
    attr_accessible :join_mailing_list
    attr_accessible :status, :flagged
    attr_accessible :professional_listing, :profession 

    validates :first_name, :last_name, :email, :presence => true
    validates :email, :uniqueness => true
    validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})$/i
    #validates_format_of :website, :allow_blank => true, :with => /^(http|https)://[a-z0-9]+([-.]{1}[a-z0-9]+)*.[a-z]{2,5}(([0-9]{1,5})?/.*)?$/ix
#validates :phone_number, :length => { :is => 10 }, :allow_blank => true 
#validates :city, :presence => true
#validates :state, :presence => true

  # Images
    attr_accessible :avatar
    has_attached_file :avatar, :default_url => "/images/default/:style/default_user.jpg", :styles => { :medium => "275x275#", :thumb => "100x100#" }

    has_many :testimonials, :dependent => :destroy
    has_many :messages, :dependent => :destroy
    has_many :contacts, :dependent => :destroy
    has_many :horses, :dependent => :destroy
    has_many :saved_horses, :dependent => :destroy
    has_one :customer, :dependent => :destroy
    has_many :subscriptions, :dependent => :destroy
    
    def name
      name ="#{self.first_name} #{self.last_name}"  
    end
    
    def gmaps4rails_address
        "#{self.address} #{self.city}, #{self.state}" 
    end

    def gmaps4rails_sidebar
        "<span>#{first_name}</span>"
    end
end
