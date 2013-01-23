class Business < ActiveRecord::Base
  belongs_to :user
  attr_accessible :city, :description, :name, :phone, :state, :website
end
