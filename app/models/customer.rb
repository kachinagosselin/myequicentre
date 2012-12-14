class Customer < ActiveRecord::Base
  attr_accessible :stripe_customer_token, :user_id
end
