class Contact < ActiveRecord::Base
  belongs_to :user
  attr_accessible :contact_id, :contact_name, :user_id
end
