class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :mailchimp

  # Setup accessible (or protected) attributes for your model
    attr_accessible :role_ids, :as => :admin
    attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :phone_number, :website
    attr_accessible :join_mailing_list

    validates :first_name, :last_name, :email, :presence => true
    validates :email, :uniqueness => true
    validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})$/i

  # Images
    attr_accessible :avatar, :avatar_file_name
    attr_accessor :avatar_file_name
    has_attached_file :avatar, :default_url => "/images/default/:style/default_user.jpg", :styles => { :medium => "275x275#", :thumb => "100x100#" }, :path => ":rails_root/images/system/:attachment/:id/:style/:filename", :url => "/images/:attachment/:id/:style/:filename"
    
  # For Inbox
  has_many :messages, :dependent => :destroy
    
  #Horses
  has_many :horses, :dependent => :destroy
end
