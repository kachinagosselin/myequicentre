class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  validates_presence_of :plan_id
  validates_presence_of :user_id
  validates_presence_of :email
    
    attr_accessible :user_id, :plan_id, :email, :stripe_card_token, :number_of_listings
  attr_accessor :stripe_card_token
  
  def save_with_payment
    if stripe_card_token.present?
      customer = Stripe::Customer.create(description: "New account", plan: plan_id, card: stripe_card_token)
      Customer.new(:stripe_customer_token => customer.id, :user_id => self.user_id)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
    
end
