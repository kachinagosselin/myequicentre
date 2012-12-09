class Zip < ActiveRecord::Base
    has_many :users
    attr_accessible :city, :code, :lat, :lon, :state
end
