class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  belongs_to :horse
  validates_presence_of :plan_id
  validates_presence_of :user_id
  validates_presence_of :horse_id
  validates_presence_of :email
    
    attr_accessible :user_id, :horse_id, :plan_id, :email, :stripe_customer_token, :stripe_cardvalid_token, :number_of_listings
  attr_accessor :stripe_card_token
  
  def save_with_payment
    customer = Customer.where(:user_id => user_id).first
    if customer.present?
      stripe_customer = Stripe::Customer.retrieve(customer.stripe_customer_token)
      self.stripe_customer_token = stripe_customer.id
      self.save!
    else
      stripe_customer = Stripe::Customer.create(description: self.email, plan: self.plan_id, card: self.stripe_card_token)
        ddd
      customer = Customer.new(:stripe_customer_token => stripe_customer.id, :user_id => user_id)
      if customer.save
      self.stripe_customer_token = stripe_customer.id
      self.save!
      end
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
    
end
