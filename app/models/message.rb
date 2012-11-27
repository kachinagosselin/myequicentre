class Message < ActiveRecord::Base
  attr_accessible :content, :from_name, :title, :to_name
end
