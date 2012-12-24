class SubscriptionsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @horse = @user.horses.find(params[:horse_id])
    @subscription = @horse.subscriptions.new
    @subscription.user_id = params[:user_id]
  end

  def create
Stripe.api_key = ENV['STRIPE_API_KEY']
    @user = User.find(params[:user_id])
    @horse = @user.horses.find(params[:subscription][:horse_id])
    @customer = @user.customer
    @existing_subscription = @user.subscriptions.first

    if @customer.present? &&  @existing_subscription.present?
    stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
    number = stripe_customer.subscription.quantity
    new_number = number + 1
    @subscription = @horse.subscriptions.build(params[:subscription])
    @subscription.update_attribute(:state, "active")
    @horse.update_attribute(:active, true)
    stripe_customer.update_subscription(:plan => params[:subscription][:plan_id], :quantity => new_number)
        
    elsif @customer.present?
    stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
    @subscription = @horse.subscriptions.build(params[:subscription])
    @subscription.update_attribute(:state, "active")
    @horse.update_attribute(:active, true)
    stripe_customer.update_subscription(:plan => params[:subscription][:plan_id], :quantity => 1)
        
    else
    # if the credit card is valid create new customer and subscriptions
    @subscription = @horse.subscriptions.build(:plan_id => params[:subscription][:plan_id], 
    :user_id => params[:subscription][:user_id], :horse_id => params[:subscription][:horse_id], 
    :email => params[:subscription][:email],)
    @stripe_customer = Stripe::Customer.create(description: params[:subscription][:email], 
    plan: params[:subscription][:plan_id], card: params[:stripe_card_token])
    @customer = @user.build_customer(:stripe_customer_token => @stripe_customer.id)
    @customer.save
    @subscription.stripe_customer_token = @stripe_customer.id
    @customer.last_4_digits = params[:last_4_digits]
    @subscription.update_attribute(:state, "active")
    @horse.update_attribute(:active, true)
    end

    if @subscription.save
        @customer.save
        redirect_to user_path(current_user), :notice => "Thank you for activating your listing!"
    else
        redirect_to :back, :alert => "Failed to activate listing"
    end
  end


  def unsubscribe
Stripe.api_key = ENV['STRIPE_API_KEY']
    @user = User.find(params[:user_id])
    @horse = @user.horses.find(params[:horse_id])
    @customer = @user.customer
    @subscription = @user.subscriptions.find(params[:id])
    stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
    number = stripe_customer.subscription.quantity
    #if there are multiple subscriptions then decrement count
    if number > 1
    new_number = number - 1  
    stripe_customer.update_subscription(:plan => "001", :quantity => new_number)  
    @horse.update_attribute(:active, false)
    @subscription.destroy
    redirect_to :back, :notice => "You have successfully unsubscribed!"
    else
    #if this is the last subscription, cancel the subscription
    stripe_customer.cancel_subscription
    @subscription.destroy
    @horse.update_attribute(:active, false)
    redirect_to :back, :notice => "You have successfully unsubscribed! 
    And you have no more subscriptions"
    end
  end
  
end
