class SavedHorse < ActiveRecord::Base
  belongs_to :user
  attr_accessible :horse_id, :saved
end
