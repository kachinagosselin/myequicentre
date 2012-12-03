class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
    attr_accessible :role_ids, :as => :admin
    attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :phone_number, :website
  
    validates :name, :email, :presence => true
    validates :email, :uniqueness => true
    
  # Images
    attr_accessible :avatar, :avatar_file_name
    attr_accessor :avatar_file_name
    has_attached_file :avatar, :default_url => "/images/default/:style/default_user.png", :styles => { :medium => "300x300>", :thumb => "100x100>" }, :path => ":rails_root/images/system/:attachment/:id/:style/:filename", :url => "/images/:attachment/:id/:style/:filename"
    
  # For Inbox
  has_many :messages, :dependent => :destroy
    
  #Horses
  has_many :horses, :dependent => :destroy
end
