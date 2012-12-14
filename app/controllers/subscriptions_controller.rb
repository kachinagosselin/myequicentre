class SubscriptionsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @horse = @user.horses.find(params[:horse_id])
    @subscription = @horse.subscriptions.new
    @subscription.user_id = params[:user_id]
  end

  def create
    @user = User.find(params[:user_id])
    @horse = @user.horses.find(params[:subscription][:horse_id])
    @customer = Customer.where(:user_id => params[:user_id]).first
    @existing_subscription = Subscription.where(:user_id => params[:user_id]).first
    if @customer.present? &&  @existing_subscription.present?
    stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
    number = stripe_customer.subscription.quantity
    new_number = number + 1
    @subscription = @horse.subscriptions.build(params[:subscription])
    @subscription.update_attribute(:state, "active")
    @horse.update_attribute(:sale_status, "active")
    stripe_customer.update_subscription(:plan => "45454545", :quantity => new_number)    
    elsif @customer.present?
    stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
    @subscription = @horse.subscriptions.build(params[:subscription])
    @subscription.state = "active"
    @horse.update_attribute(:sale_status, "active")
    stripe_customer.update_subscription(:plan => "45454545", :quantity => 1)    
    else
    # if the credit card is valid create new customer and subscriptions
    @subscription = @horse.subscriptions.build(:plan_id => params[:subscription][:plan_id], 
    :user_id => params[:subscription][:user_id], :horse_id => params[:subscription][:horse_id], 
    :email => params[:subscription][:email],)
    @stripe_customer = Stripe::Customer.create(description: params[:subscription][:email], 
    plan: params[:subscription][:plan_id], card: params[:stripe_card_token])
    @customer = Customer.new(:stripe_customer_token => @stripe_customer.id, :user_id => params[:user_id])
    @subscription.stripe_customer_token = @stripe_customer.id
    @subscription.state = "active"
    @horse.update_attribute(:sale_status, "active")
    end

    if @subscription.save
        @customer.save
        redirect_to user_path(current_user), :notice => "Thank you for activating your listing!"
    else
        redirect_to :back, :alert => "Failed to activate listing"
    end
  end


  def unsubscribe
    @user = User.find(params[:user_id])
    @horse = @user.horses.find(params[:horse_id])
    @customer = Customer.where(:user_id => params[:user_id]).first
    @subscription = Subscription.find(params[:id])
    
    #If customer and subscription
    if @customer.present?
    stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
    number = stripe_customer.subscription.quantity
    #if there are multiple subscriptions then decrement count
    if number > 1
    new_number = number - 1  
    @subscription.destroy
    @horse.update_attribute(:sale_status, "inactive")
    stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
    stripe_customer.update_subscription(:plan => "45454545", :quantity => new_number)  
    redirect_to user_path(current_user), :notice => "You have successfully unsubscribed!"
    else
    #if this is the last subscription, cancel the subscription
    @subscription.destroy
    @horse.update_attribute(:sale_status, "inactive")
    stripe_customer.cancel_subscription
    redirect_to user_path(current_user), :notice => "You have successfully unsubscribed! 
    And you have no more subscriptions"
    end
    end
  end
  
  def show
    @subscription = Subscription.find(params[:id])
  end
end
